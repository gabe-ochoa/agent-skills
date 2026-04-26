# Pre-launch checklist

Don't publish until every box is ✅. Each item should take <2 minutes to verify.

## Functionality

- [ ] Sign up with new email → confirmation email arrives → click link → land on onboarding
- [ ] Complete onboarding → land on dashboard
- [ ] Hero feature works end-to-end with real persistence
- [ ] Sign out → sign back in → state restored
- [ ] Password reset email works
- [ ] Google OAuth works (if enabled)

## Payments

- [ ] Stripe in LIVE mode, not test
- [ ] Free tier limit enforced with upgrade CTA at the boundary
- [ ] Test card subscribes successfully → DB row appears in `subscriptions`
- [ ] Webhook fires (check `supabase--edge_function_logs stripe-webhook`)
- [ ] Customer portal opens → cancel works → DB updates within 30s
- [ ] Trial countdown visible somewhere in UI

## Email

- [ ] Custom domain verified (DKIM, SPF, DMARC all green)
- [ ] Welcome email arrives within 1 minute of signup
- [ ] Subscription confirmation email arrives after first payment
- [ ] Every email has a working unsubscribe link
- [ ] Unsubscribed email cannot receive further sends (test with a 2nd account)

## SEO

- [ ] `curl -I https://yourapp.com/` returns 200
- [ ] `curl -I https://yourapp.com/upgrade` returns 200 (NOT 301/302)
- [ ] View source on `/` shows correct `<title>`, `<meta description>`, `<link rel="canonical">`
- [ ] JSON-LD validates at https://validator.schema.org/
- [ ] `sitemap.xml` accessible, all URLs return 200
- [ ] `robots.txt` references sitemap
- [ ] OG image renders in https://opengraph.xyz/
- [ ] Lighthouse SEO score ≥ 95 on landing page

## Security

- [ ] No secrets in client code (search for `sk_`, `whsec_`, raw API keys)
- [ ] RLS enabled on every public table (`supabase--linter`)
- [ ] No `service_role` key in client code
- [ ] Roles in separate `user_roles` table (not on profiles)

## Domain & hosting

- [ ] Custom domain DNS propagated (`dig yourapp.com`)
- [ ] HTTPS works, no mixed content warnings
- [ ] `www` redirects to apex (or vice versa) — pick one canonical host
- [ ] 404 page is branded, not default

## Analytics

- [ ] `signup` event fires on signup
- [ ] `onboarding_completed` event fires
- [ ] `hero_action_completed` event fires
- [ ] `checkout_started` and `subscribed` events fire
- [ ] You can query `user_events` to see real activity

## Post-launch (first 48 hours)

- [ ] Submit sitemap to Google Search Console
- [ ] Submit sitemap to Bing Webmaster Tools
- [ ] Post launch announcement on the 2–3 channels where the persona lives
- [ ] Monitor `supabase--edge_function_logs` for errors hourly on day 1
- [ ] DM the first 5 signups personally to ask what they think

## Week 1 review

- [ ] Funnel report: visitors → signups → onboarding complete → hero action → paid
- [ ] Identify the biggest drop-off step
- [ ] Pick ONE thing to improve next week
