#!/bin/bash

source ../../test_functions.sh

# check if binary and library targets are defined
test_query "//..." '322ea635e87dc0dc79f0de48986a11fa' 'expected :helloworld and :somethingexternal_lib'

# check the type
test_query "kind('cc_binary', //:helloworld)" '8b8b81d760010b7d5dca72511c7abc39' 'expected binary target'
test_query "kind('cc_library', //:somethingexternal_lib)" '05fdcd7cf82bacde621e25c473e57b29' 'expected library target'

# check the dependencies
test_query "deps(:helloworld, 1)" '0c48ea8ed0427f23f5a2958b4ca5c1f6' ":helloworld should depend on :somethingexternal_lib and helloworld.cc" '^//'
test_query "deps(:somethingexternal_lib, 1)" 'f76a31a84ee04eabfc136f5ab51e9dee' ":somethingexternal_lib should depend on somethingexternal.cc and somethingexternal.h" '^//'

# check the output
[ "$(bazel run :helloworld 2>/dev/null)" = "it's working!" ] || fail "unexpected output from :helloworld"

echo "Tests passed!"