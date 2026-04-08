import { add, subtract, multiply, divide, factorial } from "../src/math";

describe("math", () => {
  describe("add", () => {
    it("adds two positive numbers", () => {
      expect(add(2, 3)).toBe(5);
    });
    it("handles negative numbers", () => {
      expect(add(-1, 1)).toBe(0);
    });
  });

  describe("subtract", () => {
    it("subtracts two numbers", () => {
      expect(subtract(5, 3)).toBe(2);
    });
  });

  describe("multiply", () => {
    it("multiplies two numbers", () => {
      expect(multiply(4, 5)).toBe(20);
    });
    it("handles zero", () => {
      expect(multiply(4, 0)).toBe(0);
    });
  });

  describe("divide", () => {
    it("divides two numbers", () => {
      expect(divide(10, 2)).toBe(5);
    });
    it("throws on division by zero", () => {
      expect(() => divide(10, 0)).toThrow("Cannot divide by zero");
    });
  });

  describe("factorial", () => {
    it("computes factorial of 5", () => {
      expect(factorial(5)).toBe(120);
    });
    it("returns 1 for 0 and 1", () => {
      expect(factorial(0)).toBe(1);
      expect(factorial(1)).toBe(1);
    });
    it("throws for negative numbers", () => {
      expect(() => factorial(-1)).toThrow("Negative numbers not supported");
    });
  });
});
