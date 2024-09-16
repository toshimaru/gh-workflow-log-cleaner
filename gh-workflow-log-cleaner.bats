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
  assert_output_contains 'gh workflow-log-cleaner [<workflow-id> | <workflow-name> | <filename>] [options]'
  assert_output_contains 'setup	active	114854128
test	active	114855097'
}

@test "with help option" {
  run ./gh-workflow-log-cleaner --help
  [ "$status" -eq 0 ]
  assert_output_contains 'gh workflow-log-cleaner [<workflow-id> | <workflow-name> | <filename>] [options]'
  assert_output_contains 'setup	active	114854128
test	active	114855097'
}

@test "with a workflow-name and limit option" {
  run ./gh-workflow-log-cleaner setup --limit 1
  [ "$status" -eq 0 ]
  assert_output_contains "Deleting run ID:"
  assert_output_contains "✓ Request to delete workflow submitted."
}

@test "with limit option and a workflow-name" {
  run ./gh-workflow-log-cleaner --limit 1 setup
  [ "$status" -eq 0 ]
  assert_output_contains "Deleting run ID:"
  assert_output_contains "✓ Request to delete workflow submitted."
}

@test "with an invalid option" {
  run ./gh-workflow-log-cleaner setup --invalid
  [ "$status" -eq 1 ]
  assert_output_contains "Unknown option: --invalid"
}

@test "without a workflow" {
  run ./gh-workflow-log-cleaner --limit 1
  [ "$status" -eq 1 ]
  assert_output_contains "Error: Specify a workflow to delete the log"
}

@test "with an invalid workflow-name" {
  run ./gh-workflow-log-cleaner invalid
  [ "$status" -eq 0 ]
  assert_output_contains "could not find any workflows named invalid"
}
