cmake_minimum_required(VERSION 3.16)
project(ProjectX2.0) #update project name

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

enable_testing()

add_subdirectory(src)

add_executable(${PROJECT_NAME} main.cpp ) #this executes main.cpp file present in the root project directory

## This file is used to create the fuzzer configuration (.yaml) file
## Initialize your fuzz project with the command: cifuzz init

## Add the following two lines to it to enable fuzz testing
find_package(cifuzz NO_SYSTEM_ENVIRONMENT_PATH)
enable_fuzz_testing()

## Update this file to correctly point to your created fuzz test file. If you have multiple fuzz test files you'll have to write
## multiple lines. For example, for two designed test files 1 and 2, the following two lines should be added
add_fuzz_test(test test/test.cpp)
# add_fuzz_test(<name_to_run_program> test/test2.cpp)

## Next, correctly point to the linked source files present in /src folder
target_link_libraries(test PRIVATE calculator)
## Note: <name_of_source_function> is the name you'll assign to your source_code in the second CMakelists.txt file present in /src folder
