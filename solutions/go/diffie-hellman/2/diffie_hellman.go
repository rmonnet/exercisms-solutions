package diffiehellman

import (
    "math/big"
    "crypto/rand"
)

// Diffie-Hellman-Merkle key exchange
// Private keys should be generated randomly.

var two = big.NewInt(2)

func PrivateKey(p *big.Int) *big.Int {
    pMinus2 := new(big.Int).Sub(p, two)
    key, err := rand.Int(rand.Reader, pMinus2)
    if err != nil {
        panic(err)
    }
    return key.Add(key, two)
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
