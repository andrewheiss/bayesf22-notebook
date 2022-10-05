data {
  int<lower = 0> n;
  vector[n] Y;
  vector[n] X;
}

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
  vector[n] log_lik;
  
  for (i in 1:n) {
    log_lik[i] = normal_lpdf(Y[i] | mu[i], sigma);
    Y_rep[i] = normal_rng(mu[i], sigma);
  }
}
