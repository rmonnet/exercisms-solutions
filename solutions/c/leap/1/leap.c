#include "leap.h"

bool is_divisible_by(int n, int m);

bool leap_year(int year) {

    return is_divisible_by(year, 4) 
        && (!is_divisible_by(year, 100) || is_divisible_by(year, 400));
}

bool is_divisible_by(int n, int m) {
    return (n % m) == 0;
}