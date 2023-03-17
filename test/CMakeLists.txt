cmake_minimum_required (VERSION 3.21)
project (main)

set(CMAKE_C_STANDARD 23)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread -fexceptions -frtti")
file(GLOB_RECURSE SOURCE_FILES main.cpp)
add_library (mylib STATIC lib.cpp)
add_executable (${PROJECT_NAME} ${SOURCE_FILES})
# set(Boost_USE_STATIC_LIBS        ON) # only find static libs
# set(Boost_USE_MULTITHREADED      ON)
# # set(Boost_USE_STATIC_RUNTIME    OFF)
find_package(Boost 1.79.0 REQUIRED COMPONENTS 
    date_time 
    filesystem 
    serialization
    atomic 
    json
    log_setup 
    log 
    program_options
    system 
    url 
)

find_package(OpenSSL 1.1.1 REQUIRED)
find_package(ZLIB REQUIRED)
message("ZLIB_LIBRARIES=${ZLIB_LIBRARIES}")
target_link_libraries(${PROJECT_NAME} 
    ${Boost_LIBRARIES}
    ${OPENSSL_LIBRARIES}
    ${ZLIB_LIBRARIES}
    # ZLIB::ZLIB
)
target_link_libraries(${PROJECT_NAME} mylib)
install(TARGETS ${PROJECT_NAME} DESTINATION ".")