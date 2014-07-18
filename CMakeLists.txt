# CMake rules by Mani Monajjemi (mmonajje@sfu.ca) - June 2014
# To build the demo independently:
# g++ -o demo demo.cpp -I/usr/include/eigen2 -I<PATH_TO_STRUCK_INCLUDEDIR> -L<PATH_TO_STRUCK_LIB> -lstruck `pkg-config --libs --cflags opencv`

cmake_minimum_required(VERSION 2.6)
find_package(PkgConfig)

project(strucktracker)
set(st_VERSION_MAJOR 4)
set(st_VERSION_MINOR 0)
set(st_VERSION_PATCH 1)
set(st_VERSION_STRING ${st_VERSION_MAJOR}.${st_VERSION_MINOR}.${st_VERSION_PATCH})

set(libstruck_SOURCES
        src/Config.cpp
        src/Features.cpp
        src/HaarFeature.cpp
        src/HaarFeatures.cpp
        src/HistogramFeatures.cpp
        src/ImageRep.cpp
        src/LaRank.cpp
        src/MultiFeatures.cpp
        src/RawFeatures.cpp
        src/Sampler.cpp
        src/Tracker.cpp
        src/GraphUtils/GraphUtils.cpp
)

set(CMAKE_BUILD_TYPE Release)

pkg_check_modules(EIGEN2 REQUIRED eigen2)
find_package(OpenCV REQUIRED)

include_directories("${PROJECT_SOURCE_DIR}/include" ${EIGEN2_INCLUDE_DIRS} ${OpenCV_INCLUDE_DIRS})
set(CMAKE_CXX_FLAGS "-Wall ${EIGEN2_CXXFLAGS_OTHER} ${OpenCV_CXXFLAGS_OTHER}")

add_library(struck SHARED ${libstruck_SOURCES})
set_target_properties(struck PROPERTIES VERSION ${st_VERSION_STRING} SOVERSION ${st_VERSION_MAJOR})
target_link_libraries(struck ${EIGEN2_LIBRARIES} ${OpenCV_LIBRARIES})

add_executable(demo examples/demo.cpp)
target_link_libraries(demo struck)

install(TARGETS struck
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
)

install(FILES include/struck/Tracker.h include/struck/Config.h include/struck/struck.h include/struck/Rect.h
  DESTINATION include/struck
)
