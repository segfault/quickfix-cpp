set(quickfix_python_VERSION_MAJOR 16)
set(quickfix_python_VERSION_MINOR 0)
set(quickfix_python_VERSION_PATCH 1)
set(quickfix_python_VERSION ${quickfix_python_VERSION_MAJOR}.${quickfix_python_VERSION_MINOR}.${quickfix_python_VERSION_PATCH} )

set(quickfix_python_SOURCES QuickfixPython.cpp)
set(quickfix_python_lib_name _${PROJECT_NAME})

add_library(${quickfix_python_lib_name} SHARED  ${quickfix_python_SOURCES})

target_include_directories(${quickfix_python_lib_name} PRIVATE ${PROJECT_SOURCE_DIR} ${PROJECT_SOURCE_DIR}/src/C++)

target_link_libraries(${quickfix_python_lib_name} ${PROJECT_NAME})

if (HAVE_SSL)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DHAVE_SSL=1")
  target_link_libraries(${quickfix_python_lib_name} ${PROJECT_NAME} ${OPENSSL_LIBRARIES})
endif()

set_target_properties(${quickfix_python_lib_name} PROPERTIES VERSION ${quickfix_python_VERSION} SOVERSION ${quickfix_python_VERSION_MAJOR} PREFIX "")

if (NOT SKBUILD_PROJECT_NAME)
  install(TARGETS ${quickfix_python_lib_name} DESTINATION lib/python3)
  install(DIRECTORY ${PROJECT_SOURCE_DIR}/src/python/ DESTINATION lib/python3
        FILES_MATCHING PATTERN "quickfix*.py"
        PATTERN test EXCLUDE)
else()
  file(GLOB MY_PY_TEMPLATES "${PROJECT_SOURCE_DIR}/src/python/*.py.in")

  foreach(py_in_file IN LISTS MY_PY_TEMPLATES)
    get_filename_component(py_name "${py_in_file}" NAME_WE)
	set(py_out_file "${PROJECT_SOURCE_DIR}/src/python/${py_name}.py")

    configure_file(
        "${py_in_file}"
        "${py_out_file}"
        @ONLY
    )
  endforeach()


  install(TARGETS ${quickfix_python_lib_name} DESTINATION ${SKBUILD_PROJECT_NAME})
  install(DIRECTORY ${PROJECT_SOURCE_DIR}/src/python/ DESTINATION ${SKBUILD_PROJECT_NAME}
	      FILES_MATCHING PATTERN "quickfix*.py"
		  PATTERN _fields EXCLUDE
		  PATTERN test EXCLUDE)
  install(DIRECTORY ${PROJECT_SOURCE_DIR}/src/python/ DESTINATION ${SKBUILD_PROJECT_NAME}
          FILES_MATCHING PATTERN "__init__.py")
endif()
