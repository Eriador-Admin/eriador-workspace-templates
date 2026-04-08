export interface Product {
  id: string;
  name: string;
  description: string;
  priceInCents: number;
  currency: string;
}

export const products: Product[] = [
  {
    id: "prod_basic",
    name: "Basic Plan",
    description: "Essential features for individuals",
    priceInCents: 999,
    currency: "usd",
  },
  {
    id: "prod_pro",
    name: "Pro Plan",
    description: "Advanced features for teams",
    priceInCents: 2999,
    currency: "usd",
  },
  {
    id: "prod_enterprise",
    name: "Enterprise Plan",
    description: "Full platform access with priority support",
    priceInCents: 9999,
    currency: "usd",
  },
];
