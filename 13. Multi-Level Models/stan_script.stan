data{
    int<lower=1> N;
    int<lower=1> N_tank;
    int surv[N];
    int density[N];
    int tank[N];
}
parameters{
    vector[N_tank] a_tank;
    real a;
    real<lower=0> sigma;
}
model{
    vector[N] p;
    sigma ~ cauchy( 0 , 1 );
    a ~ normal( 0 , 1 );
    a_tank ~ normal( a , sigma );
    for ( i in 1:N ) {
        p[i] = a_tank[tank[i]];
    }
    surv ~ binomial_logit( density , p );
}
generated quantities{
    vector[N] p;
    for ( i in 1:N ) {
        p[i] = a_tank[tank[i]];
    }
}
