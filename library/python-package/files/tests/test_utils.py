from {{PACKAGE_NAME}} import greet, add


def test_greet():
    assert greet("World") == "Hello, World!"


def test_add():
    assert add(1, 2) == 3


def test_add_negative():
    assert add(-1, 1) == 0
