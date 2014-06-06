TARGET	= struck

CC = g++
CFLAGS = -c -Wall -O3 -DNDEBUG $(shell pkg-config --cflags eigen2 opencv)
LDFLAGS = $(shell pkg-config --libs eigen2 opencv)

SOURCES =	src/Config.cpp \
			src/Features.cpp \
			src/HaarFeature.cpp \
			src/HaarFeatures.cpp \
			src/HistogramFeatures.cpp \
			src/ImageRep.cpp \
			src/LaRank.cpp \
			src/MultiFeatures.cpp \
			src/RawFeatures.cpp \
			src/Sampler.cpp \
			src/Tracker.cpp \
			src/main.cpp \
			src/GraphUtils/GraphUtils.cpp

OBJECTS = $(SOURCES:%.cpp=%.o)
DEPS = $(OBJECTS:.o=.d)

.PHONY: all clean

all: $(TARGET)

-include $(DEPS)
	
$(TARGET): $(OBJECTS) 
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@

%.o : %.cpp
	$(CC) $(CFLAGS) -MM -MF $(patsubst %.o,%.d,$@) $<
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm -f $(OBJECTS)
	rm -f $(DEPS)
	rm -f $(TARGET)

