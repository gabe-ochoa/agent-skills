# Stateful System Testing Guide

A guide for testing distributed and stateful systems. Covers formal specification, property-based testing, linearizability verification, and sustained load testing with correctness verification.

Learned from the Journal (WAL Service) project. Each layer catches bugs the previous layer misses.

---

## When to Use This

- Building a new stateful service (databases, caches, queues, logs)
- Adding replication or consensus to an existing system
- Any system where "don't lose data" is a requirement

---

## Layered Testing Strategy

Build tests in this order. Each layer is faster than the next. An agent iterates in the fast layers (seconds) and promotes to slow layers for validation.

| Layer | Tool | Speed | What It Catches |
|-------|------|-------|-----------------|
| 1. Formal spec | TLA+ | Design time | Protocol design bugs (fencing races, quorum gaps) |
| 2. Reference model | In-memory oracle | Instant | Specification of correct behavior |
| 3. Property tests | Rapid (Go) / proptest (Rust) | Seconds | Edge cases in state transitions |
| 4. Linearizability | Porcupine (Go) | Seconds | Concurrency violations |
| 5. Load + correctness | Custom harness + HdrHistogram | Minutes | Data integrity under sustained load |
| 6. Fault injection | Load test + node kills | Minutes | Durability and recovery |
| 7. DST / Jepsen | Gosim, Turmoil, Jepsen | Hours (nightly) | Rare interleavings, real fault behavior |

---

## Layer 1: TLA+ Formal Specification

Write before any code. Model the core protocol, not the full system.

**What to model:**
- State transitions (leader election, append, seal, recovery)
- Safety invariants (no data loss, no forks, fencing correctness)
- Failure scenarios (node crash, network partition, stale leader)

**Bound the model** to keep TLC tractable: 3 nodes, 2 writers, 3-5 records.

**Starting points:**
- [BookKeeper TLA+ spec](https://github.com/Vanlightly/bookkeeper-tlaplus) for SWMR log with fencing
- [CockroachDB TLA+ specs](https://github.com/cockroachdb/cockroach/tree/master/docs/tla-plus)
- AWS's [formal methods paper](https://cacm.acm.org/research/how-amazon-web-services-uses-formal-methods/)

**Output:** `tla/<project>.tla` and `tla/<project>.cfg`

---

## Layer 2: Reference Model

An in-memory, obviously-correct implementation. Not optimized. Not thread-safe. This is the oracle that property tests compare against.

```
// Go example
type Stream struct {
    records   []Record
    lastSeq   uint64
    epoch     uint64
    sealed    bool
    truncated uint64
}
```

Every operation on the real system must produce the same result as the same operation on the reference model. If they diverge, the real system has a bug.

**Key rule:** The reference model must be simple enough that you can read it and say "obviously this is correct." If it needs comments to explain, it's too complex.

---

## Layer 3: Property-Based Tests

Use a state machine test framework. Generate random sequences of operations. Apply each operation to both the reference model and the real implementation. Check they agree after every step.

**Go:** [Rapid](https://pgregory.net/rapid) with `StateMachineActions`
**Rust:** [proptest](https://proptest-rs.github.io/proptest/) with state machine pattern

**Actions to test:**
- Valid operations (append, read, seal, truncate)
- Invalid operations (stale sequence, stale epoch, append after seal)
- Edge cases (empty records, truncate past all data, seal empty stream)

**Run 1000+ checks.** Rapid found a real bug (LastSeq after truncation) in 8 checks during the Journal project.

---

## Layer 4: Linearizability

Run concurrent operations and verify the history is linearizable: there exists a sequential ordering consistent with real-time order and the sequential specification.

**Go:** [Porcupine](https://github.com/anishathalye/porcupine). Define a `Model` with `Init`, `Step`, `Equal`. Run N goroutines. Record `{call_time, return_time, input, output}`. Feed to `CheckOperations`.

**What to test:** The primary write operation under concurrency. For Journal: conditional append with epoch + sequence fencing.

---

## Layer 5: Sustained Load with Correctness Verification

Not a benchmark. A correctness test that happens to run for 30+ seconds.

**Components:**
- N streams with dedicated writers and readers
- [HdrHistogram](https://github.com/HdrHistogram/hdrhistogram-go) for latency distributions (p50/p90/p99/p999)
- Per-stream tracker recording every successful append
- End-of-test verification: read all records from the system, compare to tracker

**The verification is the point.** Throughput and latency numbers are secondary. If the data doesn't match, the system is broken.

---

## Layer 6: Fault Injection Under Load

Same load test, but kill and revive nodes randomly during the run.

**What to inject:**
- Node kills (simulate process crash)
- Node revives (simulate restart)
- Overlapping kills (multiple nodes down simultaneously)

**What to verify:**
- Zero data loss on acknowledged writes
- Stale nodes are tolerated (not treated as fencing errors)
- Recovery produces consistent state

**Key finding from Journal:** A revived node stays behind until caught up. The client must distinguish "stale node" (SEQUENCE_MISMATCH from a behind node) from "fenced" (STALE_EPOCH from a newer writer). This was only discovered under fault injection load, not in unit tests.

---

## Layer 7: Deterministic Simulation / Jepsen

Run nightly, not per-commit. Too slow for agent iteration.

**Options:**
- [Gosim](https://github.com/jellevandenhooff/gosim) for Go (deterministic syscall simulation)
- [Turmoil](https://tokio.rs/blog/2023-01-03-announcing-turmoil) for Rust async
- [Jepsen](https://jepsen.io/) for real system under real faults
- [Antithesis](https://antithesis.com/) for deterministic hypervisor testing

**Design for DST from day 1:** Put all I/O behind interfaces (Clock, Network, Disk, Random). Production uses real implementations. DST uses simulated ones.

---

## Language Comparison Benchmark

When the language choice is uncertain, build both and benchmark.

**Same API, same tests, same workload.** Compare:
- Throughput (ops/sec)
- Latency distribution (p50/p99/p999)
- Tail latency under load (GC pauses vs. no GC)
- Correctness under concurrency (Go masked a bug that Rust exposed in Journal)
- Developer experience (build time, error messages, ecosystem)

**The data makes the decision.** Opinions are cheap.

---

## Structured Failure Output

Every test layer must produce machine-readable output so an agent can self-correct:

| Layer | On Failure, Output |
|-------|-------------------|
| Property tests | Minimized counterexample (sequence of operations) |
| Linearizability | Conflicting operation timeline (Porcupine HTML) |
| Load test | Which stream, which record, expected vs actual count |
| DST | Seed number for perfect reproduction |

---

## Changelog

| Date | Change |
|------|--------|
| 2026-04-02 | Initial version. Learned from Journal (WAL Service) project. |
