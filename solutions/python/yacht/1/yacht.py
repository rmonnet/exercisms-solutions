# Score categories.
# Change the values as you see fit.
YACHT = 'yatch'
ONES = 'ones'
TWOS = 'twos'
THREES = 'threes'
FOURS = 'fours'
FIVES = 'fives'
SIXES = 'sizes'
FULL_HOUSE = 'full_house'
FOUR_OF_A_KIND = 'four_of_a_kind'
LITTLE_STRAIGHT = 'little_straight'
BIG_STRAIGHT = 'big_straight'
CHOICE = 'choice'

def number_of(number, dice):
    # Count the occurences of number
    return len(list(filter(lambda v: v == number, dice)))

def yacht(dice):
    # score 50 pts if all the dices are the same
    if (len(set(dice))) == 1:
        return 50
    return 0

def full_house(dice):
    # we should have exactly 2 numbers in dice
    if len(set(dice)) != 2:
        return 0
    # with two numbers we can have a 4/1 or a 2/3 distribution
    # for a full house, we need a 2/3 distribution
    if number_of(dice[0], dice) not in [2,3]:
        return 0
    return sum(dice)

def four_of_a_kind(dice):
    # we should have 4 or 5 of a kind
    if len(set(dice)) > 2:
        return 0
    # since we have 4 dices with the same number
    # we are guaranted that the number that appears 4 times is either
    # the first or second dice
    if number_of(dice[0], dice) >= 4:
        return 4 * dice[0]
    if number_of(dice[1], dice) >= 4:
        return 4 * dice[1]
    # must be a 2/3 distribution, not what we are looking for
    return 0

def little_straight(dice):
    if sorted(dice) == [1, 2, 3, 4, 5]:
        return 30
    return 0

def big_straight(dice):
    if sorted(dice) == [2, 3, 4, 5, 6]:
        return 30
    return 0

def score(dice, category):
    if category == YACHT:
        return yacht(dice)
    elif category == ONES:
        return number_of(1, dice)
    elif category == TWOS:
        return number_of(2, dice) * 2
    elif category == THREES:
        return number_of(3, dice) * 3
    elif category == FOURS:
        return number_of(4, dice) * 4
    elif category == FIVES:
        return number_of(5, dice) * 5
    elif category == SIXES:
        return number_of(6, dice) * 6
    elif category == FULL_HOUSE:
        return full_house(dice)
    elif category == FOUR_OF_A_KIND:
        return four_of_a_kind(dice)
    elif category == LITTLE_STRAIGHT:
        return little_straight(dice)
    elif category == BIG_STRAIGHT:
        return big_straight(dice)
    elif category == CHOICE:
        return sum(dice)
    else:
        return 0
