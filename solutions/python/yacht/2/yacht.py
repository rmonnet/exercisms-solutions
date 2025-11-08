from collections import Counter

# Score categories.
# Change the values as you see fit.
(YACHT,
ONES,
TWOS,
THREES,
FOURS,
FIVES,
SIXES,
FULL_HOUSE,
FOUR_OF_A_KIND,
LITTLE_STRAIGHT,
BIG_STRAIGHT,
CHOICE) = range(12)

def number_of(number, dice):
    return Counter(dice)[number]

def yacht(dice):
    # score 50 pts if all the dices are the same
    if len(set(dice)) != 1:
        return 0
    return 50
        

def full_house(dice):
    c = Counter(dice)
    # we should have exactly 2 numbers in dice with a 3/2 distribution
    if len(c) != 2 or (3 not in c.values()):
        return 0
    return sum(dice)

def four_of_a_kind(dice):
    c = Counter(dice)
    print('1>', c)
    # we should have either
    # 2 numbers in dice with a 4/1 distribution
    # or 1 number
    if len(c) > 2 or (len(c) == 2 and 4 not in c.values()):
        return 0
    return 4 * c.most_common()[0][0]

def little_straight(dice):
    if sorted(dice) != [1, 2, 3, 4, 5]:
        return 0
    return 30

def big_straight(dice):
    if sorted(dice) != [2, 3, 4, 5, 6]:
        return 0
    return 30

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
