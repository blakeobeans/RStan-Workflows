data{
  int<lower=1> N;
  vector[N] divorce;
  vector[N] age;
  vector[N] marriage_proportion;
}

transformed data{
  vector[N] D_norm;
  vector[N] A_norm;
  vector[N] M_norm;
  D_norm = (divorce-mean(divorce))/sd(divorce);
  A_norm = (age-mean(age))/sd(age);
  M_norm = (marriage_proportion-mean(marriage_proportion))/sd(marriage_proportion);
}


parameters{
  real a;
  real bA;
  real bM;
  real<lower=0> sigma;
}

model{
  vector[N] mu;
  mu = a + bA * A_norm + bM * M_norm;
  D_norm ~ normal(mu, sigma);
  a ~ normal(0,.2);
  bA ~ normal(0,.5);
  bM ~ normal(0, 0.5);
  sigma ~ exponential(1);
}

generated quantities{
    vector[N] y_pred;
    vector[N] mu;
    
    for ( i in 1:N ) {
        mu[i] = a + bA * A_norm[i] + bM * M_norm[i];
    }
    
    for (i in 1:N) {
      y_pred[i] = normal_rng(mu[i], sigma);
    }
}
