##################################################
# Fortran with Unit Tests and Multiple Executable CMake Demo 
#
# Created by Paht Juangphanich, NASA - LTE
#
# Inspired by https://github.com/SethMMorton/cmake_fortran_template
#   and http://johannes.tax/Unit_testing_with_Fortran_and_CTest.html 
##################################################
project(GlennHT)
cmake_minimum_required(VERSION 3.5)
enable_language(C Fortran)
set(CMAKE_BUILD_TYPE "debug") # debug OR release


if (UNIX)
    set(CMAKE_Fortran_COMPILER nvfortran)
    get_filename_component(FCNAME ${CMAKE_Fortran_COMPILER} NAME)
    message(STATUS "Fortran compiler: ${FCNAME}")
    SET(CMAKE_Fortran_FLAGS_DEBUG "-g -O0 -acc -Mextend -Mpreprocess -Minfo=accel -gpu=managed -Mcuda -mp=gpu")
    SET(CMAKE_Fortran_FLAGS_RELEASE "-fast -O3 -acc -Mextend -Mpreprocess -Minfo=accel -gpu=managed -Mcuda -mp=gpu")
    
elseif(APPLE)
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
INCLUDE(${CMAKE_MODULE_PATH}/SetCTest.cmake) # <- add any libraries to this file

# add_fortran_test_executable (
#     testsuite
#     "tests/test_dry_air.f90"
#     "tests/test_helloworld.f90"
#     )

# # Link libraries to testsuite - this works with latest version of cmake 
# target_link_libraries (testsuite 
#     "tests/test_dry_air.f90"
#     "tests/test_helloworld.f90"
#     lib_material_properties
#     )