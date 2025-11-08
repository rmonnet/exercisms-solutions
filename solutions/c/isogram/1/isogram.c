#include "isogram.h"

bool is_isogram(const char phrase[]) {
    // Account for the tricky case where phrase is the null pointer
    if (phrase == 0) return false;
    
    int frequency[26] = {0};
    for (char *c = (char *)phrase; *c != '\0'; c++) {
        if ('a' <= *c && *c <= 'z') {
            if (frequency[*c-'a'] == 1) return false;
            frequency[*c-'a'] = 1;
        } else if ('A' <= *c && *c <= 'Z') {
            if (frequency[*c-'A'] == 1) return false;
            frequency[*c-'A'] = 1;
        }
    }
    return true;
}