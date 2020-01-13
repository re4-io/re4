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

set(CMAKE_CXX_STANDARD 14)

download_dependency(boost
  URL "https://dl.bintray.com/boostorg/release/1.72.0/source/boost_1_72_0.tar.gz"
  HASH SHA256=c66e88d5786f2ca4dbebb14e06b566fb642a1a6947ad8cc9091f9f445134143f
  BUILD_SCRIPT lib/boost/CMakeLists.txt
)

download_dependency(googletest
  URL "https://github.com/google/googletest/archive/release-1.10.0.tar.gz"
  HASH SHA256=9dc9157a9a1551ec7a7e43daea9a694a0bb5fb8bec81235d8a1e6ef64c716dcb
)

add_library(${PROJECT_NAME}
    source/Re4.cpp
)

target_include_directories(${PROJECT_NAME} PUBLIC include)
target_include_directories(${PROJECT_NAME} PRIVATE source)
