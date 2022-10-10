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
  alpha ~ normal(2, 0.5);
  beta[1] ~ student_t(2, 0, 1);
  beta[2] ~ student_t(2, -0.5, 2);
  beta[3] ~ student_t(2, 0, 2);
  
  // Model
  Y ~ poisson_log_glm(X, alpha, beta);
}

generated quantities {
  array[n] int Y_rep;
  vector[n] log_lik;

  vector[n] lambda_hat = alpha + X * beta;
  
  for (i in 1:n) {
    // We can use the shortcut poisson_log_glm_lpmf, which works just like 
    // poisson_log_glm from earlier
    log_lik[i] = poisson_log_glm_lpmf({Y[i]} | X[i,], alpha, beta);

    // Or we can use poisson_log_lpmf and feed it lambda_hat
    // log_lik[i] = poisson_log_lpmf(Y[i] | lambda_hat[i]);

    // Posterior predictive distribution
    Y_rep[i] = poisson_log_rng(lambda_hat[i]);
  }
}
