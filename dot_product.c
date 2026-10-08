#define _POSIX_C_SOURCE 200112L

#include <errno.h>
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

enum {
    DEFAULT_ELEMENTS = 1 << 20,
    DEFAULT_REPETITIONS = 1200,
    ALIGNMENT = 64
};

static double elapsed_seconds(const struct timespec *start,
                              const struct timespec *end) {
    return (double)(end->tv_sec - start->tv_sec) +
           (double)(end->tv_nsec - start->tv_nsec) / 1e9;
}

static size_t parse_positive_size(const char *text, const char *name) {
    char *end = NULL;
    errno = 0;
    unsigned long long value = strtoull(text, &end, 10);
    if (errno != 0 || end == text || *end != '\0' || value == 0 ||
        value > SIZE_MAX) {
        fprintf(stderr, "Invalid %s: %s\n", name, text);
        exit(EXIT_FAILURE);
    }
    return (size_t)value;
}

static void *allocate_aligned(size_t bytes) {
    void *pointer = NULL;
    int result = posix_memalign(&pointer, ALIGNMENT, bytes);
    if (result != 0) {
        fprintf(stderr, "posix_memalign(%zu): %s\n", bytes, strerror(result));
        exit(EXIT_FAILURE);
    }
    return pointer;
}

static void fill_inputs(double *left, double *right, size_t elements) {
    uint64_t state = UINT64_C(0x9e3779b97f4a7c15);
    for (size_t i = 0; i < elements; ++i) {
        state = state * UINT64_C(6364136223846793005) + 1;
        left[i] = (double)(state >> 11) / (double)(UINT64_C(1) << 53);
        state = state * UINT64_C(6364136223846793005) + 1;
        right[i] = (double)(state >> 11) / (double)(UINT64_C(1) << 53);
    }
}

__attribute__((noinline))
static double dot_product(const double *restrict left,
                          const double *restrict right,
                          size_t elements) {
    double total = 0.0;
    for (size_t i = 0; i < elements; ++i) {
        total += left[i] * right[i];
    }
    return total;
}

int main(int argc, char **argv) {
    size_t elements = argc > 1 ? parse_positive_size(argv[1], "element count")
                               : DEFAULT_ELEMENTS;
    size_t repetitions =
        argc > 2 ? parse_positive_size(argv[2], "repetition count")
                 : DEFAULT_REPETITIONS;

    if (elements > SIZE_MAX / sizeof(double)) {
        fputs("Element count is too large.\n", stderr);
        return EXIT_FAILURE;
    }

    size_t bytes = elements * sizeof(double);
    double *left = allocate_aligned(bytes);
    double *right = allocate_aligned(bytes);
    fill_inputs(left, right, elements);

    struct timespec start;
    struct timespec end;
    if (clock_gettime(CLOCK_MONOTONIC, &start) != 0) {
        perror("clock_gettime");
        free(right);
        free(left);
        return EXIT_FAILURE;
    }

    double checksum = 0.0;
    for (size_t run = 0; run < repetitions; ++run) { 
        size_t offset = run & 1;
        checksum += dot_product(left + offset, right + offset, elements - offset);
    }

    if (clock_gettime(CLOCK_MONOTONIC, &end) != 0) {
        perror("clock_gettime");
        free(right);
        free(left);
        return EXIT_FAILURE;
    }

    double seconds = elapsed_seconds(&start, &end);
    double operations = 2.0 * (double)elements * (double)repetitions;
    printf("elements=%zu repetitions=%zu checksum=%.12f elapsed=%.6f s "
           "throughput=%.3f GFLOP/s\n",
           elements, repetitions, checksum, seconds, operations / seconds / 1e9);

    free(right);
    free(left);
    return EXIT_SUCCESS;
}
