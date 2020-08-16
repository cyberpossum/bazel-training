#!/bin/bash

source ../../test_functions.sh

# check if binary and library targets are defined
test_query "//..." '1e35bd30b8cf8c32fc5fdd0cac9d5f93' 'expected :helloworld and :helloworld_lib'

# check the type
test_query "kind('cc_binary', //:helloworld)" '8b8b81d760010b7d5dca72511c7abc39' 'expected binary target'
test_query "kind('cc_library', //:helloworld_lib)" '07cafa8b14a5ccf578ea77f2f6f7987f' 'expected library target'

# check the dependencies
test_query "deps(:helloworld, 1)" '1e35bd30b8cf8c32fc5fdd0cac9d5f93' ":helloworld should depend on :helloworld_lib" '^//'
test_query "deps(:helloworld_lib, 1)" '81f99a65d659005fe996405ab09bf7e0' ":helloworld_lib should depend on helloworld.cc" '^//'

# check the output
[ "$(bazel run :helloworld 2>/dev/null)" = "it's working!" ] || fail "unexpected output from :helloworld"

echo "Tests passed!"