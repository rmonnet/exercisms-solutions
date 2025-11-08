def is_armstrong_number(number):
    digits = [int(digit) for digit in str(number)]
    exponent = len(digits)
    raised_digits = [digit**exponent for digit in digits]
    return number == sum(raised_digits)
