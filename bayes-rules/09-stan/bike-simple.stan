data {
  int<lower = 0> n;
  vector[n] Y;
  vector[n] X;
}

/*
// We could also center things here and then use it in mu below:
// mu = beta0 + beta1 * X_centered;
// See https://mc-stan.org/docs/stan-users-guide/standardizing-predictors-and-outputs.html
transformed data {
  vector[n] X_centered;
  
  X_centered = X - mean(X);
}
*/

parameters {
  real beta0;
  real beta1;
  real<lower = 0> sigma;
}

transformed parameters {
  vector[n] mu;
  mu = beta0 + beta1 * X;
}

model {
  Y ~ normal(mu, sigma);
  
  beta0 ~ normal(5000, 1000);
  beta1 ~ normal(100, 40);
  sigma ~ exponential(0.0008);
}

generated quantities {
  vector[n] Y_rep;
  
  for (i in 1:n) {
    Y_rep[i] = normal_rng(mu[i], sigma);
  }
}
