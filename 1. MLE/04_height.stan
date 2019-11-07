data{
    int<lower=1> N;
    real height[N];
}
parameters{
    real mu;
    real<lower=0> sigma;
}
model{
    sigma ~ exponential( 0.1 );
    mu ~ normal( 178 , 20 );
    height ~ normal( mu , sigma );
}

generated quantities{
  real y_pred;
  y_pred = normal_rng(mu, sigma);
}

