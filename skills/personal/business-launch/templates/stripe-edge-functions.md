# The 4 Stripe edge functions you always need

All four live in `supabase/functions/<name>/index.ts` and auto-deploy.

## 1. `create-checkout` (JWT required)

Receives: `{ priceId: string, tier: string }`
Returns: `{ url: string }` — Stripe Checkout Session URL

```ts
import Stripe from "https://esm.sh/stripe@14?target=denonext";
import { createClient } from "jsr:@supabase/supabase-js@2";

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response(null, { headers: corsHeaders });

  const stripe = new Stripe(Deno.env.get("STRIPE_SECRET_KEY")!, { apiVersion: "2024-06-20" });
  const supabase = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_ANON_KEY")!,
    { global: { headers: { Authorization: req.headers.get("Authorization")! } } }
  );

  const { data: { user } } = await supabase.auth.getUser();
  if (!user) return new Response("Unauthorized", { status: 401 });

  const { priceId } = await req.json();

  // Reuse customer if exists
  const customers = await stripe.customers.list({ email: user.email!, limit: 1 });
  const customerId = customers.data[0]?.id;

  const session = await stripe.checkout.sessions.create({
    customer: customerId,
    customer_email: customerId ? undefined : user.email,
    mode: "subscription",
    line_items: [{ price: priceId, quantity: 1 }],
    subscription_data: { trial_period_days: 7 },
    success_url: `${req.headers.get("origin")}/dashboard?subscribed=1`,
    cancel_url: `${req.headers.get("origin")}/upgrade?canceled=1`,
  });

  return Response.json({ url: session.url }, { headers: corsHeaders });
});
```

## 2. `customer-portal` (JWT required)

Receives: nothing
Returns: `{ url: string }` — Billing Portal URL

Same skeleton as above, but call `stripe.billingPortal.sessions.create({ customer, return_url })`.

## 3. `check-subscription` (JWT required)

Idempotent sync from Stripe → DB. Call this on dashboard mount as a safety net.

```ts
const subs = await stripe.subscriptions.list({ customer: customerId, limit: 1 });
const sub = subs.data[0];
const tier = sub ? mapPriceIdToTier(sub.items.data[0].price.id) : "free";
const status = sub?.status ?? "inactive";

await supabase.from("subscriptions").upsert({
  user_id: user.id,
  tier,
  status,
  stripe_customer_id: customerId,
  stripe_subscription_id: sub?.id,
  current_period_start: sub ? new Date(sub.current_period_start * 1000).toISOString() : null,
  current_period_end: sub ? new Date(sub.current_period_end * 1000).toISOString() : null,
}, { onConflict: "user_id" });
```

## 4. `stripe-webhook` (JWT OFF, signature verified)

In `supabase/config.toml`:
```toml
[functions.stripe-webhook]
verify_jwt = false
```

```ts
const sig = req.headers.get("stripe-signature")!;
const body = await req.text();
const event = stripe.webhooks.constructEvent(body, sig, Deno.env.get("STRIPE_WEBHOOK_SECRET")!);

switch (event.type) {
  case "customer.subscription.created":
  case "customer.subscription.updated":
  case "customer.subscription.deleted":
    // upsert subscriptions row
    break;
  case "invoice.payment_failed":
    // send dunning email
    break;
}
```

Register webhook in Stripe dashboard: `https://<project-ref>.supabase.co/functions/v1/stripe-webhook` → events above.

## Secrets to set

```
STRIPE_SECRET_KEY        (sk_live_... or sk_test_...)
STRIPE_WEBHOOK_SECRET    (whsec_...)
```

Use `secrets--add_secret` for each.
