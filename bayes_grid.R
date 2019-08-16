# Generate test data
n_obs = 25
x = 2 + rnorm(n_obs)
y = 4 + 3*x + 2*rnorm(n_obs)

# Setting up grid
b0 = seq(from=-1, to=10, length.out = 50)
b1 = seq(from=-1, to=10, length.out = 50)
b2 = seq(from=-1, to=10, length.out = 50)
sig = seq(from=0.1, to=5, length.out = 30)

hypothesis = expand.grid(b0, b1, b2, sig)
names(hypothesis) = c("b0","b1","b2","sig")

prior = rep(1, nrow(hypothesis))

likelihood = rep(1, nrow(hypothesis))
for (i in 1:length(y)){
  mean = hypothesis$b0 + hypothesis$b1*x1[i] + hypothesis$b2*x2[i] 
  sd =  hypothesis$sig 
  likelihood = likelihood*dnorm(y[i], mean=mean, sd=sd) 
}

posterior = likelihood*prior/sum(likelihood*prior)

#Sampling from the posterior
samp_idx = sample(x = seq_len(nrow(hypothesis)), size = 1e6, prob = posterior, replace = T)
samp = hypothesis[samp_idx,]
samp_summary = data.frame('Intercept_Mean'=mean(samp$b0),
                          'Slope1_Mean'=mean(samp$b1),
                          'Slope2_Mean'=mean(samp$b2),
                          'SD_Mean'=mean(samp$sig))
samp_summary

hist(samp$b0, breaks = 50)

#Checking against an OLS fit
mod = lm(y ~ x1 + x2)
mod$coefficients
