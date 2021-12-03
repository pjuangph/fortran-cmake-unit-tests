function (mangle_fortran_name CNAME FNAME)
    set (TMP)
    if (WIN32)
        string (TOUPPER "${FNAME}" TMP)
    else ()
        string (TOLOWER "${FNAME}_" TMP)
    endif ()
    set (${CNAME} ${TMP} PARENT_SCOPE)
endfunction ()


function (mangle_fortran_filename_list MANGLED)
    set (TMP)
    foreach (TFILE ${ARGN})
        string (REGEX REPLACE ".f90$" "" TESTNAME ${TFILE})
        mangle_fortran_name (C_TESTNAME ${TESTNAME})
        list (APPEND TMP ${C_TESTNAME})
    endforeach ()
    set (${MANGLED} ${TMP} PARENT_SCOPE)
endfunction()


function (add_fortran_test_executable TARGET)
    # function name: add_fortran_test_executable
    #   Make sure you add the library below
    # Args
    #   TARGET - list of functions 
    message("ARGC=\"${ARGC}\"") # Argument count
    message("ARGN=\"${ARGN}\"") # Optional Arguments
    message("ARGV=\"${ARGV}\"") # All arguments 
    message("ARGV0=\"${ARGV0}\"") # First Argument
    message("ARGV1=\"${ARGV1}\"") # Secondd Argument

    list(SUBLIST ${TARGET} 0 -1 TARGETS)
    message("TARGETS= ${TARGETS}")

    set (TEST_FILES ${ARGN})

    mangle_fortran_filename_list (TEST_FILES_MANGLED ${TEST_FILES})

    create_test_sourcelist (_ main.c ${TEST_FILES_MANGLED})

    add_library (${TARGET}_fortran ${TEST_FILES})
    add_executable (${TARGET} main.c)
    # include all custom libraries below e.g. lib_material_properties
    target_link_libraries (${TARGET} 
        ${TARGET}_fortran
        lib_material_properties
    )
    

    set (INDEX 0)
    list (LENGTH TEST_FILES LEN)
    while (${LEN} GREATER ${INDEX})
        list (GET TEST_FILES ${INDEX} TEST_FILE)
        list (GET TEST_FILES_MANGLED ${INDEX} TEST_FILE_MANGLED)
        add_test (
            NAME ${TEST_FILE}
            COMMAND $<TARGET_FILE:${TARGET}> ${TEST_FILE_MANGLED})
        math (EXPR INDEX "${INDEX} + 1")
    endwhile ()
endfunction ()