#include "lib1/somethingexternal.h"
#include "lib3/somethingexternal.h"
#include <iostream>

int main() {
    std::cout << get_something_external_1() << " " << get_something_external_3() << std::endl;
    return 0;
}