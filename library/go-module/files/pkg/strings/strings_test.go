package strings

import "testing"

func TestReverse(t *testing.T) {
	tests := []struct {
		input, want string
	}{
		{"hello", "olleh"},
		{"", ""},
		{"a", "a"},
	}
	for _, tt := range tests {
		got := Reverse(tt.input)
		if got != tt.want {
			t.Errorf("Reverse(%q) = %q, want %q", tt.input, got, tt.want)
		}
	}
}

func TestContainsInsensitive(t *testing.T) {
	if !ContainsInsensitive("Hello World", "hello") {
		t.Error("expected true")
	}
	if ContainsInsensitive("Hello", "xyz") {
		t.Error("expected false")
	}
}
