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

cmake_minimum_required(VERSION 3.7)

project(re4 VERSION 0.0.0)

set(CMAKE_CXX_STANDARD 17)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(FetchLib)

fetch_lib(googletest
  URL "https://github.com/google/googletest/archive/release-1.10.0.tar.gz"
  URL_HASH SHA256=9dc9157a9a1551ec7a7e43daea9a694a0bb5fb8bec81235d8a1e6ef64c716dcb
)

set(USE_SYSTEM_TZ_DB ON CACHE BOOL "Use the operating system's timezone database" FORCE)
set(BUILD_TZ_LIB ON CACHE BOOL "Build/install of TZ library" FORCE)

fetch_lib(date
  GIT_REPOSITORY "https://github.com/re4-io/date.git"
  GIT_TAG c8d311f6f1b9ede6f66d510012da8002ef07a895
)

add_library(${PROJECT_NAME}
  source/Re4.cpp
)

target_include_directories(${PROJECT_NAME} PUBLIC include)
target_include_directories(${PROJECT_NAME} PRIVATE source)

add_executable(${PROJECT_NAME}-test
  test/Test.cpp
)

target_link_libraries(${PROJECT_NAME}-test gtest_main)
