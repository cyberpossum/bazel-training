#!/bin/bash

source ../../test_functions.sh

# check if only one target is defined
test_query '//...' '8b8b81d760010b7d5dca72511c7abc39' 'expected :helloworld target'

# check the type
test_query "kind('cc_binary', //:helloworld)" '8b8b81d760010b7d5dca72511c7abc39' 'expected binary target'

# check the dependencies
test_query "deps(:helloworld, 1)" '6ccf0701e8af1960e54ef24672254dff' ":helloworld should depend on helloworld.cc" '^//'

# check the output
[ "$(bazel run :helloworld 2>/dev/null)" = "it's working!" ] || fail "unexpected output from :helloworld"

echo "Tests passed!"