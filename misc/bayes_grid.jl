
b0_true = 4
b1_true = 3
s_true = 2
num_observations = 10

x = 11 .+ randn(num_observations)*2
y = b0_true .+ b1_true*x .+ randn(length(x))*s_true;

scatter(x,y, legend=false)


hyp_b0 = LinRange(3, 6, 101)
hyp_b1 = LinRange(2.5, 3.5, 101)
hyp_sig = LinRange(0.01, 4, 101)