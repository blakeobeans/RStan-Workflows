data{
    int<lower=1> N;
    real height[N];
    real weight[N];
	real xbar;
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
    
    for ( i in 1:N ) {
        mu[i] = a + b * (weight[i] - xbar);
    }
    height ~ normal( mu , sigma );
}
generated quantities{
    vector[N] y_pred;
    vector[N] mu;
    
    for ( i in 1:N ) {
        mu[i] = a + b * (weight[i] - xbar);
    }
    
    for (i in 1:N) {
      y_pred[i] = normal_rng(mu[i], sigma);
    }
}

