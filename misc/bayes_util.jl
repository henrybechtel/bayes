
function normal_pdf(x, mu=0, sig=1)
    """
    Returns the probability of observing value x from
    a the given normal distribution.
    """
    return exp(-(x-mu)^2/(2*sig^2))/sqrt(2*pi*sig^2)
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

function linear_regression_1(x, y, hyp_b0, hyp_b1, hyp_sig)
    prior = ones(length(hyp_b0),length(hyp_b1),length(hyp_sig))
    unnormalized_posterior = zeros(size(prior))
    marginal_likelihood = 0
    for i in 1:length(hyp_b0)
        b0 = hyp_b0[i]
        for j in 1:length(hyp_b1)
            b1 = hyp_b1[j]
            for k in 1:length(hyp_sig)
                s = hyp_sig[k]
                likelihood = 1
                for d in 1:length(y)
                    mean = b0 + b1*x[d]
                    likelihood *= normal_pdf(y[d], mean, s)
                end
                unnormalized_posterior[i,j,k] = likelihood*prior[i,j,k]
                marginal_likelihood += likelihood*prior[i,j,k]
            end
        end
    end
    posterior = unnormalized_posterior/marginal_likelihood
    return posterior

    val, idx = findmax(posterior)
    println("MAP Estimate for b0 is: ", hyp_b0[idx[1]])
    println("MAP Estimate for b1 is: ", hyp_b1[idx[2]])
    println("MAP Estimate for sigma is: ", hyp_sig[idx[3]])
end
