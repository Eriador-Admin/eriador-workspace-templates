/// Clamps a value between a minimum and maximum.
pub fn clamp(value: u64, min: u64, max: u64) -> u64 {
    if value < min {
        min
    } else if value > max {
        max
    } else {
        value
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_clamp_within_range() {
        assert_eq!(clamp(5, 1, 10), 5);
    }

    #[test]
    fn test_clamp_below_min() {
        assert_eq!(clamp(0, 1, 10), 1);
    }

    #[test]
    fn test_clamp_above_max() {
        assert_eq!(clamp(15, 1, 10), 10);
    }
}
