#include "armstrong_numbers.h"
#include <math.h>

bool is_armstrong_number(int candidate) {
    int remainder = candidate;
    int sum = 0;
    int power = (int)ceil(log10(candidate));
    while (remainder > 0) {
        int digit = remainder % 10;
        sum += (int)pow(digit, power);
        remainder /= 10;
    }
    return sum == candidate;
}
