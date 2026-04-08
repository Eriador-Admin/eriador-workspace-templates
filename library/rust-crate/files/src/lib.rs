//! # {{PROJECT_NAME}}
//!
//! A library crate with sample utilities.

pub mod utils;

/// Adds two numbers together.
///
/// # Examples
///
/// ```
/// let result = {{PROJECT_NAME}}::add(2, 3);
/// assert_eq!(result, 5);
/// ```
pub fn add(left: u64, right: u64) -> u64 {
    left + right
}

/// Multiplies two numbers.
pub fn multiply(left: u64, right: u64) -> u64 {
    left * right
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_add() {
        assert_eq!(add(2, 3), 5);
    }

    #[test]
    fn test_add_zero() {
        assert_eq!(add(0, 0), 0);
    }

    #[test]
    fn test_multiply() {
        assert_eq!(multiply(3, 4), 12);
    }
}
