data {
  int<lower=0> n;  // Number of rows
  int<lower=0> k;  // Number of predictors
  matrix[n,k] X;   // Predictors
  array[n] int Y;  // Outcome variable
}

parameters {
  real alpha;
  vector[k] beta;
}

model {
  // Priors
  alpha ~ normal(-1.4, 0.7);
  beta[1] ~ normal(0, 0.14);
  beta[2] ~ normal(0, 0.15);
  beta[3] ~ normal(0, 6.45);
  
  // Model
  Y ~ bernoulli_logit_glm(X, alpha, beta);
}

generated quantities {
  array[n] int Y_rep;
  vector[n] log_lik;

  vector[n] pi_hat = alpha + X * beta;
  
  for (i in 1:n) {
    // We can use the shortcut bernoulli_logit_glm_lpmf, which works just like 
    // bernoulli_logit_glm from earlier
    log_lik[i] = bernoulli_logit_glm_lpmf({Y[i]} | X[i,], alpha, beta);

    // Or we can use bernoulli_logit_lpmf and feed it pi_hat
    // log_lik[i] = bernoulli_logit_lpmf(Y[i] | pi_hat[i]);

    // Posterior predictive distribution
    Y_rep[i] = bernoulli_logit_rng(pi_hat[i]);
  }
}
