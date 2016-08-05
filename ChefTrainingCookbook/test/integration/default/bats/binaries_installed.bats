#!/usr/bin/env bats

@test "java binary is found in PATH" {
  run which java
  [ "$status" -eq 0 ]
}

@test "mysql binary is found in PATH" {
  run which mysql
  [ "$status" -eq 0 ]
}

@test "tomcat binary is found in PATH" {
  run which tomcat
  [ "$status" -eq 0 ]
}

@test "nginx binary is found in PATH" {
  run which nginx
  [ "$status" -eq 0 ]
}
