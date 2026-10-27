ifeq ($(origin CXX), default)
	CXX = g++
endif

CXXFLAGS ?= -g -Wall -Wextra -Wpedantic
LDFLAGS ?=

BUILD_DIR ?= build
BIN_DIR ?= bin
TARGET = $(BIN_DIR)/test

COMMONINC = -I./include
override CXXFLAGS += $(COMMONINC)

SRC_DIR = src

SOURCES = \
	src/list_func.cpp \
	src/read_buffer.cpp \
	src/hash.cpp \
	src/main.cpp \

OBJECTS = $(patsubst $(SRC_DIR)/%.cpp,$(BUILD_DIR)/%.o,$(SOURCES))
DEPS = $(OBJECTS:.o=.d)

.PHONY: all clean run benchmark graph_plot

all: $(TARGET)

$(TARGET): $(OBJECTS)
	@mkdir -p $(@D)
	$(CXX) $^ -o $@ $(LDFLAGS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -MMD -MP -c $< -o $@

run: $(TARGET)
	./$(TARGET)

benchmark: $(TARGET)
	@mkdir -p cache_grind
	valgrind --tool=cachegrind --cache-sim=yes --branch-sim=yes \
		--cachegrind-out-file=cache_grind/cg_new.out ./$(TARGET)
	cg_annotate cache_grind/cg_new.out

graph_plot: $(TARGET)
	mkdir -p csv images
	./$(TARGET)
	gnuplot csv/plot.plt
clean:
	rm -rf $(BUILD_DIR) $(TARGET)

-include $(DEPS)

