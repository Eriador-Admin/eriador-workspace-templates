export async function validateOrder(orderId: string, items: string[]): Promise<void> {
  console.log(`Validating order ${orderId} with ${items.length} items`);
  if (items.length === 0) throw new Error("Order must have at least one item");
}

export async function processPayment(orderId: string, amount: number): Promise<void> {
  console.log(`Processing payment of $${(amount / 100).toFixed(2)} for order ${orderId}`);
  // Simulate payment processing
}

export async function shipOrder(orderId: string, customer: string): Promise<void> {
  console.log(`Shipping order ${orderId} to ${customer}`);
  // Simulate shipping
}

export async function sendConfirmation(orderId: string, customer: string): Promise<void> {
  console.log(`Sending confirmation for order ${orderId} to ${customer}`);
  // Simulate email
}
