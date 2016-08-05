#!/usr/bin/env bats

@test "/data directory found in path" {
  run stat /data
  [ "$status" -eq 0 ]
}

@test "hello.txt file found in path" {
  run stat /data/hello.txt
  [ "$status" -eq 0 ]
}
