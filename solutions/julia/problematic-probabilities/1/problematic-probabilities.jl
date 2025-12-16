rationalize(successes, trials) = successes .// trials

probabilities(successes, trials) = float(rationalize(successes, trials))

function checkmean(successes, trials)
    rational_mean = sum(rationalize(successes, trials)) / length(successes)
    prob_mean = sum(probabilities(successes, trials)) / length(successes)
    if float(rational_mean) == prob_mean
        return true
    else
        return rational_mean
    end
end

function checkprob(successes, trials)
    rational_total = prod(rationalize(successes, trials))
    prob_total = prod(probabilities(successes, trials))
    if float(rational_total) == prob_total
        return true
    else
        return rational_total
    end
end
