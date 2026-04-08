use {{PROJECT_NAME}}::{add, multiply};

#[test]
fn test_add_and_multiply() {
    let sum = add(2, 3);
    let product = multiply(sum, 4);
    assert_eq!(product, 20);
}
