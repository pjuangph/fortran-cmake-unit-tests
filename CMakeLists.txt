##################################################
# Fortran with Unit Tests and Multiple Executable CMake Demo 
#
# Created by Paht Juangphanich, NASA - LTE
#
# Inspired by https://github.com/SethMMorton/cmake_fortran_template
#   and http://johannes.tax/Unit_testing_with_Fortran_and_CTest.html 
##################################################
project(GlennHT)
cmake_minimum_required(VERSION 3.13)
enable_language(C Fortran)
set(CMAKE_BUILD_TYPE "debug") # debug OR release


if (NOT ${APPLE})
    set(CMAKE_FC_COMPILER /opt/nvidia/hpc_sdk/Linux_x86_64/21.9/compilers/bin/nvfortran)
    message(STATUS "Fortran compiler: ${CMAKE_FC_COMPILER}")
    add_compile_options(-acc -O3 -Mfree -Mr8 -i8 -Mextend -Mpreprocess -Minfo=accel -gpu=managed -Mcuda -mp=gpu -L$(CUDA_PATH)/lib64 -lnvToolsExt)
else()
    get_filename_component(FCNAME ${CMAKE_Fortran_COMPILER} NAME)
    message(STATUS "Fortran compiler: ${FCNAME}")
    if(FCNAME STREQUAL "pgf90")
        unset(CMAKE_SHARED_LIBRARY_LINK_Fortran_FLAGS)
    endif(FCNAME STREQUAL "pgf90")
endif()

# Set fortran build directory 
set(lib ${CMAKE_SOURCE_DIR}/build/lib) # Any built libraries    
SET(CMAKE_Fortran_MODULE_DIRECTORY ${lib})

# If necessary, use the RELATIVE flag, otherwise each source file may be listed 
# with full pathname. RELATIVE may makes it easier to extract an executable name
# automatically.
add_executable(main executables/main.f90)
add_executable(helloworld executables/helloworld.f90)
add_subdirectory(modules/material_properties)
target_link_libraries(main lib_material_properties)


## Unit testing 
enable_testing()
#[[ This include contains 
the function add_fortran_test_executable ]] 
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake-modules) 
INCLUDE(${CMAKE_MODULE_PATH}/SetCTest.cmake) 

add_fortran_test_executable (
    testsuite
    "tests/test_dry_air.f90"
    "tests/test_helloworld.f90"
    )
# Link libraries to testsuite
target_link_libraries (testsuite 
        lib_material_properties
    )