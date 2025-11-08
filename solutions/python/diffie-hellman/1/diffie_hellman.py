from random import random

def private_key(p):
    return int(1 + random() * (p-1))


def public_key(p, g, private):
    return g**private % p


def secret(p, public, private):
    return public**private % p

