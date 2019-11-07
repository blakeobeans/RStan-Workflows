data {
int<lower=1> N; //N has to go first
vector[N] W;
vector[N] E;
int Q[N];
int id[N];
}

parameters{
real aW;
real bEW;
real<lower=0> sigmaW;
real aE;
real bQE;
real<lower=0> sigmaE;
vector[N] U; //this is what's new- define unknown data as a parameter
}

model{
  vector[N] muW; //model 1 (must be defined first)
  vector[N] muE; //model 2 (must be defined first)
  //model1
  for (i in 1:N) {
  muW[i] = aW + bEW * E[i] + U[id[i]]; //loop may not be nec. usually, but given U ~ fn(i), it is in this case
  }
  sigmaW ~ exponential(1);
  aW ~ normal(0, 0.5);
  bEW ~ normal(0,1);
  //model2
  for (i in 1:N) {
  muE[i] = aE + bQE * Q[i] + U[id[i]];
  }
  sigmaE ~ exponential(1);
  aE ~ normal(0, 0.5);
  bQE ~ normal(0, 1);
  //prior for U
  U ~ normal(0,1); 
  //moved priors to bottom
  W ~ normal(muW, sigmaW);//model1
    E ~ normal(muE, sigmaE);//model2
}

