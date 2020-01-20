#  Copyright (C) 2019  Vladimir Berlev
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <https://www.gnu.org/licenses/>.

set(FL_CMAKELISTS_URL "${CMAKE_CURRENT_LIST_DIR}/FetchLib/CMakeLists-url.txt.in")
set(FL_CMAKELISTS_GIT "${CMAKE_CURRENT_LIST_DIR}/FetchLib/CMakeLists-git.txt.in")

function(fetch_lib FL_NAME)
  set(FL_PREFIX             "${CMAKE_CURRENT_SOURCE_DIR}/lib")
  set(FL_PROJECT_DIR        "${FL_PREFIX}/${FL_NAME}-fetch")
  set(FL_SOURCE_PROJECT_DIR "${FL_PREFIX}/${FL_NAME}")

  execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory "${FL_PROJECT_DIR}")

  cmake_parse_arguments(FL "" "URL;URL_HASH;GIT_REPOSITORY;GIT_TAG;BUILD_SCRIPT" "" ${ARGN})

  if((DEFINED FL_URL) AND (NOT DEFINED FL_GIT_REPOSITORY))
    if (NOT DEFINED FL_URL_HASH)
      message(FATAL_ERROR "URL_HASH must be passed")
    endif()

    set(FL_CMAKELISTS "${FL_CMAKELISTS_URL}")
  elseif((DEFINED FL_GIT_REPOSITORY) AND (NOT DEFINED FL_URL))
    if (NOT DEFINED FL_GIT_TAG)
      message(FATAL_ERROR "GIT_TAG must be passed")
    endif()

    set(FL_CMAKELISTS "${FL_CMAKELISTS_GIT}")
  else()
    message(FATAL_ERROR "One and only one of {URL, GIT_REPOSITORY} must be passed")
  endif()

  # Prepare download project CMakeLists.txt file
  configure_file("${FL_CMAKELISTS}" "${FL_PROJECT_DIR}/CMakeLists.txt" @ONLY)

  # Download project generate step
  execute_process(
    COMMAND "${CMAKE_COMMAND}" -G "${CMAKE_GENERATOR}" .
    WORKING_DIRECTORY "${FL_PROJECT_DIR}"
    RESULT_VARIABLE RESULT
  )
  if (RESULT)
    message(FATAL_ERROR "Generate step for ${FL_PROJECT_DIR} failed")
  endif()

  # Download project build step
  execute_process(
    COMMAND "${CMAKE_COMMAND}" --build .
    WORKING_DIRECTORY "${FL_PROJECT_DIR}"
    RESULT_VARIABLE RESULT
  )
  if (RESULT)
    message(FATAL_ERROR "Build step for ${FL_PROJECT_DIR} failed")
  endif()
 
  if (DEFINED FL_BUILD_SCRIPT)
    file(COPY "${FL_BUILD_SCRIPT}" DESTINATION "${FL_SOURCE_PROJECT_DIR}")
  endif()

  add_subdirectory("${FL_SOURCE_PROJECT_DIR}")
endfunction()
