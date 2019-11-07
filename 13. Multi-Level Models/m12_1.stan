
data{
    int<lower=1> N;
    int<lower=1> N_tank;
    int surv[N];
    int density[N];
    int tank[N];
}
parameters{
    vector[N_tank] a_tank;
}
model{
    vector[N] p;
    a_tank ~ normal( 0 , 5 );
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