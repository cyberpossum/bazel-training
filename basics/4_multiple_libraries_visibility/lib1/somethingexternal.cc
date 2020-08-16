#include "somethingexternal.h"
#include "lib2/somethingexternal.h"
#include "lib3/somethingexternal.h"
#include <string>

std::string get_something_external_1() {
  return std::string("External 1 importing: ") + get_something_external_2();
}