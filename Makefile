CC := gcc
WARNINGS := -Wall -Wextra -Wpedantic -Werror
COMMON_FLAGS := -std=c17 $(WARNINGS) -g -fno-omit-frame-pointer
BASELINE_FLAGS := -O0
OPTIMIZED_FLAGS := -O3 -march=native -ffast-math
BUILD_DIR := build

.PHONY: all baseline optimized clean disassembly

all: baseline optimized

$(BUILD_DIR):
	mkdir -p $@

baseline: $(BUILD_DIR)/dot_product_O0

optimized: $(BUILD_DIR)/dot_product_O3

$(BUILD_DIR)/dot_product_O0: dot_product.c | $(BUILD_DIR)
	$(CC) $(COMMON_FLAGS) $(BASELINE_FLAGS) $< -o $@

$(BUILD_DIR)/dot_product_O3: dot_product.c | $(BUILD_DIR)
	$(CC) $(COMMON_FLAGS) $(OPTIMIZED_FLAGS) $< -o $@

disassembly: all
	objdump -d -Mintel --disassemble=dot_product $(BUILD_DIR)/dot_product_O0 > $(BUILD_DIR)/dot_product_O0.asm
	objdump -d -Mintel --disassemble=dot_product $(BUILD_DIR)/dot_product_O3 > $(BUILD_DIR)/dot_product_O3.asm

clean:
	rm -rf $(BUILD_DIR) results
