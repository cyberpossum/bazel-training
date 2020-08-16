#include "somethingexternal.h"
#include "lib3/somethingexternal.h"
#include <string>

std::string get_something_external_2() {
  return std::string("External 2 importing: ") + get_something_external_3();
}