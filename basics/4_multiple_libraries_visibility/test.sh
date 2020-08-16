#!/bin/bash

source ../../test_functions.sh

# check if binary and library targets are defined
test_query "//..." '2cdc41459ab2e4663b69887adb4416e2' 'expected :main, //lib1, //lib2 and //lib3'

# check the type
test_query "kind('cc_binary', //:main)" 'db518443823c3844c7770ef2f2911a93' 'expected binary target'
test_query "kind('cc_library', //lib1)" '3086222f35083c382dd01800a69c71fe' 'expected library target //lib1'
test_query "kind('cc_library', //lib2)" '60f89b51563f7d7ace6564e3b2847b7e' 'expected library target //lib2'
test_query "kind('cc_library', //lib3)" '4f13659055a52ae39f699490f9dc26b2' 'expected library target //lib3'

# check the dependencies
test_query "deps(//:main, 1)" '042a229895395d3db43f64a47f7a579e' ":main should depend on main.cc, //lib1 and //lib3" '^//'
test_query "deps(//lib1, 1)" '1ed965e0b87844a02d3b6eb051d2fb0e' "//lib1 should depend on somethingexternal.cc, somethingexternal.h, //lib2 and //lib3" '^//'
test_query "deps(//lib2, 1)" '353820ac2a859d05c3ecca3e19427526' "//lib2 should depend on somethingexternal.cc, somethingexternal.h and //lib3" '^//'
test_query "deps(//lib3, 1)" '027d4111bc733b2ea8194a99bffbcb38' "//lib3 should depend on somethingexternal.cc, somethingexternal.h" '^//'

# check visibility
test_query "visible(//:main, //...)" 'f3f5f459b1f5161d0e0ecd54204dd68e' "only //lib1 and //lib3 should be visible to //:main"
test_query "visible(//lib1, //...)" '88dfc328c716f686d6b60e8b804b3cda' "only //lib2 and //lib3 should be visible to //lib1"
test_query "visible(//lib2, //...)" '92f7eca55364c49d698e429fc54550cb' "only //lib3 should be visible to //lib2"
test_query "visible(//lib3, //...)" '4f13659055a52ae39f699490f9dc26b2' "no other targets should be visible to //lib3"

# check the output
[ "$(bazel run :main 2>/dev/null)" = "External 1 importing: External 2 importing: External 3 External 3" ] || fail "unexpected output from :main"

echo "Tests passed!"