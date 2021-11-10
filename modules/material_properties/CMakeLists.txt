cmake_minimum_required(VERSION 3.13)

set(LIBRARY_NAME "lib_material_properties")
# Add the source files
add_library(${LIBRARY_NAME} STATIC 
        material_parameters.f90
        dry_air.f90
        moist_air.f90
    )

# This makes it so that config.f90 is found
target_include_directories(${LIBRARY_NAME} PUBLIC ${CMAKE_SOURCE_DIR}/executables) 
