import { capitalize, slugify, truncate } from "../src/string-utils";

describe("string-utils", () => {
  describe("capitalize", () => {
    it("capitalizes the first letter", () => {
      expect(capitalize("hello")).toBe("Hello");
    });
    it("handles empty string", () => {
      expect(capitalize("")).toBe("");
    });
    it("handles already capitalized", () => {
      expect(capitalize("Hello")).toBe("Hello");
    });
  });

  describe("slugify", () => {
    it("converts text to slug", () => {
      expect(slugify("Hello World")).toBe("hello-world");
    });
    it("removes special characters", () => {
      expect(slugify("Hello, World!")).toBe("hello-world");
    });
    it("trims leading/trailing dashes", () => {
      expect(slugify(" --Hello-- ")).toBe("hello");
    });
  });

  describe("truncate", () => {
    it("does not truncate short strings", () => {
      expect(truncate("Hello", 10)).toBe("Hello");
    });
    it("truncates long strings with ellipsis", () => {
      expect(truncate("Hello World, this is long", 10)).toBe("Hello W...");
    });
    it("handles exact length", () => {
      expect(truncate("Hello", 5)).toBe("Hello");
    });
  });
});
