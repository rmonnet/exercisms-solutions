
function swap(domino) {
    return [domino[1], domino[0]]
}

function remove(dominoes, index) {
    const result = [...dominoes]
    result.splice(index, 1)
    return result
}

function subchain(start, end, dominoes) {

    if (dominoes.length == 1) {
        const domino = dominoes[0]
        if (domino[0] == start && domino[1] == end) return [domino]
        if (domino[0] == end && domino[1] == start) return [swap(domino)]
        return null
    }

    for (let i = 0; i < dominoes.length; i++) {
        const domino = dominoes[i]
        if (domino[0] == start) {
            const chain = subchain(domino[1], end, remove(dominoes, i))
            if (chain) return [domino].concat(chain)
        } else if (domino[1] == start) {
            const chain = subchain(domino[0], end, remove(dominoes, i))
            if (chain) return [swap(domino)].concat(chain)
        }
    }
    return null
}

export function chain(dominoes) {

    if (dominoes.length == 0) return []
    if (dominoes.length == 1) {
        if (dominoes[0][0] == dominoes[0][1]) return dominoes
        return null
    }
    for (let i = 0; i < dominoes.length; i++) {
        const domino = dominoes[i]
        const chain = subchain(domino[1], domino[0], remove(dominoes, i))
        if (chain) return [domino].concat(chain)
        const altChain = subchain(domino[0], domino[1], remove(dominoes, i))
        if (altChain) return [swap(domino)].concat(altChain)
    }
    return null
};

