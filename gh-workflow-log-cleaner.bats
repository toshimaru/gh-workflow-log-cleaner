#!/usr/bin/env bats

# Custom assertion function to check if output contains a substring
assert_output_contains() {
  local substring="$1"
  [[ "$output" == *"$substring"* ]] || {
    echo "Expected '$output' to contain '$substring'"
    return 1
  }
}

@test "without parameter" {
  run ./gh-workflow-log-cleaner
  [ "$status" -eq 0 ]
  expected_output="Usage:
gh workflow-log-cleaner [<workflow-id> | <workflow-name> | <filename>]

Available workflows:
- setup
- test"
  [ "$output" = "$expected_output" ]
}

@test "with a workflow-name parameter" {
  run ./gh-workflow-log-cleaner setup
  [ "$status" -eq 0 ]
  assert_output_contains "Deleting run ID:"
}
