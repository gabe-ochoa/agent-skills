// Drop into src/components/SEOHead.tsx. Use react-helmet-async or set tags directly.
// Usage:
//   <SEOHead
//     title="Pricing — YourApp"
//     description="Simple plans starting at $4.99/mo. 7-day free trial."
//     canonical="https://yourapp.com/pricing"
//   />

import { useEffect } from "react";

interface SEOHeadProps {
  title: string;              // <60 chars, include primary keyword
  description: string;        // <160 chars, action-oriented
  canonical: string;          // absolute URL
  ogImage?: string;           // absolute URL, 1200x630
  noindex?: boolean;
  jsonLd?: Record<string, unknown>;
}

const setMeta = (selector: string, attr: string, value: string) => {
  let el = document.head.querySelector<HTMLMetaElement>(selector);
  if (!el) {
    el = document.createElement("meta");
    const [, key, name] = selector.match(/\[(\w+)="([^"]+)"\]/) ?? [];
    if (key && name) el.setAttribute(key, name);
    document.head.appendChild(el);
  }
  el.setAttribute(attr, value);
};

const setLink = (rel: string, href: string) => {
  let el = document.head.querySelector<HTMLLinkElement>(`link[rel="${rel}"]`);
  if (!el) {
    el = document.createElement("link");
    el.setAttribute("rel", rel);
    document.head.appendChild(el);
  }
  el.setAttribute("href", href);
};

export const SEOHead = ({
  title,
  description,
  canonical,
  ogImage = "https://yourapp.com/og-default.png",
  noindex = false,
  jsonLd,
}: SEOHeadProps) => {
  useEffect(() => {
    document.title = title;
    setMeta('meta[name="description"]', "content", description);
    setMeta('meta[name="robots"]', "content", noindex ? "noindex,nofollow" : "index,follow");
    setLink("canonical", canonical);

    // Open Graph
    setMeta('meta[property="og:title"]', "content", title);
    setMeta('meta[property="og:description"]', "content", description);
    setMeta('meta[property="og:url"]', "content", canonical);
    setMeta('meta[property="og:image"]', "content", ogImage);
    setMeta('meta[property="og:type"]', "content", "website");

    // Twitter
    setMeta('meta[name="twitter:card"]', "content", "summary_large_image");
    setMeta('meta[name="twitter:title"]', "content", title);
    setMeta('meta[name="twitter:description"]', "content", description);
    setMeta('meta[name="twitter:image"]', "content", ogImage);

    // JSON-LD
    const existing = document.getElementById("page-jsonld");
    if (existing) existing.remove();
    if (jsonLd) {
      const script = document.createElement("script");
      script.type = "application/ld+json";
      script.id = "page-jsonld";
      script.textContent = JSON.stringify(jsonLd);
      document.head.appendChild(script);
    }
  }, [title, description, canonical, ogImage, noindex, jsonLd]);

  return null;
};
