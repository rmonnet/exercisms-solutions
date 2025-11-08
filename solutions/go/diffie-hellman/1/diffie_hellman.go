package diffiehellman

import (
    "math/big"
    "math/rand"
    "time"
)

// Diffie-Hellman-Merkle key exchange
// Private keys should be generated randomly.

var rng = rand.New(rand.NewSource(time.Now().UnixNano()))

func PrivateKey(p *big.Int) *big.Int {
    one := big.NewInt(1)
    key := big.NewInt(0)
    // big.Int.Rand() returns a value in [0, n), we want it in (1, n).
    for key.Cmp(one) != 1 {
        key.Rand(rng, p)
    }
	return key
}

func PublicKey(private, p *big.Int, g int64) *big.Int {
    return new(big.Int).Exp(big.NewInt(g), private, p)
}

func NewPair(p *big.Int, g int64) (*big.Int, *big.Int) {
	private := PrivateKey(p)
    public := PublicKey(private, p, g)
    return private, public
}

func SecretKey(private1, public2, p *big.Int) *big.Int {
	return new(big.Int).Exp(public2, private1, p)
}
