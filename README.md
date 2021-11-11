# Using CMake and CTests with Fortran and open acc
This repository gives an example of how you can use cmake to auto-generate makefiles and unit tests

## Why is this important
Makefiles are needed to compile c code and fortran code. Dependenacies are compiled in order before they are used. In a large program it's hard to discern which dependancies should be compiled first, middle, and last. Often developers are worried about code that works while also tinkering with makefile to make sure it compiles. This can take a lot of time and make it harder for other developers to contribute code. 

Makefiles are messy. Code is often compiled directly in the source folder which can lead to a lot of .o files for linking along with executables combined with your code. This is disorganized. All compilation should occur in a separate folder that way the developer is less distracted. 


## Enter Cmake
Cmake handles the depenancies for you. You simply create a library and link it. An example of creating a library is shown in the [modules folder](https://github.com/pjuangph/fortran-cmake-unit-tests/tree/main/modules/material_properties). Cmake allows you to organize modules in folder groups but when they are built they are moved into build/libs folder. Organization can be useful when you have a large program that has many functionalities. 


### Multiple Executable Support
It is possible to compile multiple executables in a single makefile. In this example 2 executables are compiled, Helloworld and main.f90. 


# How to compile
- Step 1 Configuring the build directory: run ./configure.sh script. This sets up the makefile.
- Step 2 Building the code: run ./build.sh script which navigates to the build directory and calls make
- Step 3 Running all Unit tests: run ./run_tests.sh to run unit tests using CTests. Note this runs all the test. To run specific tests you can simply navigate to build folder and run ./testsuite [test number] 
- Step 4 Cleaning up: this is as simple as deleting the build folder or running ./clean.sh 

# Using Intellisense to error check before compiling
Download and install visual studio code https://code.visualstudio.com 
Install the following extensions:
- Fortran https://marketplace.visualstudio.com/items?itemName=Gimly81.fortran
- Cmake https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools 
- Remote SSH https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh 

All these extensions will help with debugging the code before compile time. 
Note: CMake doesn't work with .f03 or f08 file extensions. Use .f90 for cmake to understand that this is a fortran file.

If you are using mac and remote ssh, make sure you set the timeout to something longer than 15 sec https://stackoverflow.com/a/62423178/1599606 

