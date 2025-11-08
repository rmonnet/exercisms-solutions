def steps(number):
    if number <= 0:
        raise ValueError("Only positive integers are allowed")
    n_steps = 0
    while number > 1:
        n_steps += 1
        if number % 2 == 0:
            # number is even
            number = number // 2
        else:
            # number is odd
            number = 3 * number + 1
    return n_steps
    
