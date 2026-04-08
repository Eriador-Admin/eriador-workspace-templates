# {{PROJECT_NAME}}

A Go library module.

## Getting Started

```bash
bash init.sh    # verify Go toolchain
bash run.sh     # run tests
bash stop.sh    # (no-op for libraries)
```

## Project Structure

```
pkg/
  math/
    math.go         # Math utility functions
    math_test.go    # Tests and benchmarks
  strings/
    strings.go      # String utility functions
    strings_test.go # Tests
go.mod
```

## Usage

```go
import "github.com/yourorg/{{PROJECT_NAME}}/pkg/math"

result := math.Add(2, 3)
```

## Requirements

- Go 1.21+
