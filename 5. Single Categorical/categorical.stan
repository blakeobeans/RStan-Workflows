data {
  int<lower=1> N; //Variable N has to go first.
  int clade_id[N]; //categorical variable must be defined as an integer
  vector[N] K; //can be a vector[N] or real K[N]
  int<lower=1> N_clade_id;
}

parameters{
  vector[N_clade_id] a;
  real<lower=0> sigma;
}

model{
  vector[N] mu;
  a ~ normal(0, 0.5);
  sigma ~ exponential(1);
  mu = a[clade_id];
  K ~ normal(mu, sigma);
}

generated quantities{
    vector[N] mu;
    for ( i in 1:N ) {
        mu[i] = a[clade_id[i]];
    }
}

