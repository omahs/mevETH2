#!/usr/bin/env bash

forge coverage --report lcov --no-match-test "testLoad|invariant" 

lcov -r lcov.info "tests/*" -o lcov-filtered.info --rc lcov_branch_coverage=1

genhtml lcov-filtered.info -o report --branch-coverage;