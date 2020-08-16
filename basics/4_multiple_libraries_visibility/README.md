# Task
Edit the `BUILD` file in this and `lib1/`, `lib2/` and `lib3/` subdirectories, add C++ binary target named `main` and three libraries named `lib1`, `lib1` and `lib3` for the sources and headers and files in directories `lib1/`, `lib2/` and `lib3/` respectively.

The library dependency should look like this:

```
main ---> lib1 ---> lib2 --> lib3
|          |                  ^
|          |                  |
|          -------------------|
|                             |
-------------------------------
```

Binary should embed the required libraries, and use `main.cc` file as a source.

The library targets should only be visible to the targets that depend on them. `main` should be private

No C++ knowledge is required.

# Testing
Run `./test.sh` in the directory

# References:
- https://docs.bazel.build/versions/master/visibility.html
- https://docs.bazel.build/versions/master/tutorial/cpp.html
- https://docs.bazel.build/versions/3.4.0/bazel-and-cpp.html

# Hints
 - The targets that should be visible to every other targets can have `public` visibility
 - The default target for package is the package's name, e.g. `//lib1:lib1` and `//lib1` are identical
 - Use `__pkg__` to make the target visible to a package
 - Use bazel query `bazel query '//...' --output graph` to check the dependency graph