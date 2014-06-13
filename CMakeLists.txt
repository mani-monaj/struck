cmake_minimum_required(VERSION 2.6)
find_package(PkgConfig)

project(struck)

set(struck_SOURCES 
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
        src/main.cpp
        src/GraphUtils/GraphUtils.cpp
)

set(CMAKE_BUILD_TYPE Release)

pkg_check_modules(EIGEN2 REQUIRED eigen2)
find_package(OpenCV REQUIRED)

include_directories(${EIGEN2_INCLUDE_DIRS} ${OpenCV_INCLUDE_DIRS})
set(CMAKE_CXX_FLAGS "-Wall ${EIGEN2_CXXFLAGS_OTHER} ${OpenCV_CXXFLAGS_OTHER}")

add_executable(struck ${struck_SOURCES})
target_link_libraries(struck ${EIGEN2_LIBRARIES} ${OpenCV_LIBRARIES})