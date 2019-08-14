module Thames

function normal_pdf(x, mu=0, sig=1)
    """
    Returns the probability of observing value x from
    a the given normal distribution.
    """
    exp(-(x-mu)^2/(2*sig^2))/sqrt(2*pi*sig^2)
end

function weighted_sampler(wv::Array{Float64,1})
    """
    Returns index of sampled weighted vector
    """
    threshold = rand() * sum(wv)
    weight = values(wv)
    n = length(weight)
    i = 1
    cummulative_weight = weight[1]
    while cummulative_weight < threshold && i < n
        i += 1
        cummulative_weight += weight[i]
    end
    return i
end

end