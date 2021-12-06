# Using CMake and CTests with Fortran and open acc
This repository gives an example of how you can use cmake to auto-generate makefiles and unit tests. 
Inspiration for creating this example comes from:
- https://github.com/SethMMorton/cmake_fortran_template
- http://johannes.tax/Unit_testing_with_Fortran_and_CTest.html  

## Why is this important
### Dependancies
Makefiles are needed to compile c code and fortran code. Dependenacies are compiled in order before they are used. In a large program it's hard to discern which dependancies should be compiled first, middle, and last. Often developers are worried about code that works while also tinkering with makefile to make sure it compiles. This can take a lot of time and make it harder for other developers to contribute code. 

### Organization

Makefiles are messy. Code is often compiled directly in the source folder which can lead to a lot of .o files for linking along with executables combined with your code. This is disorganized. All compilation should occur in a separate folder that way the developer is less distracted. 

### Platform compatibility
Making a makefile that can compile across platforms can be very difficult. You might end up with many different makefiles and find yourself compiling using `make -f [makefile for windows]` 

## Enter Cmake
Cmake handles the depenancies for you. You simply create a library and link it. An example of creating a library is shown in the [modules folder](https://github.com/pjuangph/fortran-cmake-unit-tests/tree/main/modules/material_properties). Cmake allows you to organize modules in folder groups but when they are built they are moved into build/libs folder. Organization can be useful when you have a large program that has many functionalities. 


### Multiple Executable Support
It is possible to compile multiple executables in a single makefile. In this example 2 executables are compiled, Helloworld and main.f90. 

### Cross Platform compilation
Cmake works on windows, mac, linux x86 and arm so those new m1 macs can compile fortran code. Note: gfortran doesn't work with m1 macs, you have to use gcc and documentation for fortran with gcc is very limited. 

### Support for Git
Cmake can add modules from git by simply passing a url. 

## Resources for CMake
Check out this youtube playlist 
https://www.youtube.com/watch?v=nlKcXPUJGwA&list=PLalVdRk2RC6o5GHu618ARWh0VO0bFlif4&t=0s

# How to compile
On NAS you need to load cmake module. Ctest may only be available on pfe26 and pfe27. These are the toss operating system https://www.nas.nasa.gov/hecc/support/kb/news/testing-period-for-toss-operating-system-migration_611.html
> module use /nasa/modulefiles/testing; module load pkgsrc/2021Q2 

Also Load modules for nvidia hpc
- module load [path to nvidia modules on nas]
- List of all modules for NVIDIA on NAS `ls -ltr /nasa/nvidia/hpc_sdk/modulefiles`
- Loading the latest nvfortran compiler `module load /nasa/nvidia/hpc_sdk/modulefiles/nvhpc/21.7`

Older cmake < 3.22 cannot include libraries to executables after they have been defined inside a function
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

# Best Practices for Fortran
- You can use the `include` but provide a relative reference to the file otherwise you get errors in your intellisense
- Don't try to use `#include` like you do in C. Fortran is not C and this is weird and breaks intellisense
- Tabs should be 4 spaces not 0 not 1 not 2 but 4. Reading a giant loop with 2 tab spaces is very annoying. 
- Comment your code using doxygen standards https://www.doxygen.nl/manual/docblocks.html#fortranblocks This allows websites to be built around your code so that people can search your comments.
