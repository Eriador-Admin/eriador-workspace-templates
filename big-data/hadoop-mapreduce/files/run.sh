#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

rm -rf data/output
java -cp "target/{{ARTIFACT_ID}}-1.0.jar:$(mvn dependency:build-classpath -q -DincludeScope=provided -Dmdep.outputFile=/dev/stdout)" \
  com.example.WordCountDriver data/input data/output

echo "Job complete. Results in data/output/"
