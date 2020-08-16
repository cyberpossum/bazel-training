# Task
Edit the `BUILD` file, add C++ binary target named `helloworld` and a library target called `somethingexternal_lib` to compile from `somethingexternal.cc` source using `somethingexternal.h` header. 
Binary should embed the library, and use `helloworld.cc` file as source.

No C++ knowledge is required.

# Testing
Run `./test.sh` in the directory

# References:
- https://docs.bazel.build/versions/master/tutorial/cpp.html
- https://docs.bazel.build/versions/3.4.0/bazel-and-cpp.html