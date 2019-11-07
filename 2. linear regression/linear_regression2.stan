data{
    int<lower=1> N;
    real height[N];
    real weight[N];
	  int xbar;
}
parameters{
    real a;
    real b;
    real<lower=0> sigma;
}
model{
    vector[N] mu;
    sigma ~ exponential( .1 );
    b ~ lognormal( 0 , 1 );
    a ~ normal( 178 , 20 );
    mu = a + b * (weight - xbar);
    height ~ normal( mu , sigma );
}
generated quantities{
    vector[N] y_pred;
    vector[N] mu;
    mu = a + b * (weight - xbar);
    y_pred = normal_rng(mu, sigma);
}

