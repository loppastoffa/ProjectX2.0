#include <assert.h>
#include "../src/calculator.h"
#include <cifuzz/cifuzz.h>
#include <fuzzer/FuzzedDataProvider.h>
#include <cstdint>
#include <cstddef>
#include <string>

FUZZ_TEST_SETUP() {
  // Perform any one-time setup required by the FUZZ_TEST function.
}

FUZZ_TEST(const uint8_t *data, size_t size) {
  // FuzzedDataProvider provides convenience methods that turn the raw fuzzer
  // data into common types. Use it to generate parameters for the function you
  // want to fuzz:
  //
  FuzzedDataProvider fuzzed_data(data, size);
  float num1 = fuzzed_data.ConsumeFloatingPoint<float>();
  float num2 = fuzzed_data.ConsumeFloatingPoint<float>();
  char op = fuzzed_data.PickValueInArray({'+', '-', '*', '/'});

  
  try {
    int result = calculator(num1, op, num2);
    assert(result >= INT_MIN && result <= INT_MAX);

  } catch (const std::exception &e) {
    // Could handle exceptions here
  }
}
