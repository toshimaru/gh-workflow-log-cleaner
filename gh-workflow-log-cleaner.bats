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
gh workflow-log-cleaner [<workflow-id> | <workflow-name> | <filename>] [options]

Options:
  -h, --help  Show this help message and exit
  --limit     Limit the number of runs to delete (default: 1000)

Available workflows:
setup	active	114854128
test	active	114855097"
  [ "$output" = "$expected_output" ]
}

@test "with help option" {
  run ./gh-workflow-log-cleaner --help
  [ "$status" -eq 0 ]
  expected_output="Usage:
gh workflow-log-cleaner [<workflow-id> | <workflow-name> | <filename>] [options]

Options:
  -h, --help  Show this help message and exit
  --limit     Limit the number of runs to delete (default: 1000)

Available workflows:
setup	active	114854128
test	active	114855097"
  [ "$output" = "$expected_output" ]
}

@test "with a workflow-name parameter" {
  run ./gh-workflow-log-cleaner setup --limit 1
  [ "$status" -eq 0 ]
  assert_output_contains "Deleting run ID:"
  assert_output_contains "✓ Request to delete workflow submitted."
}
