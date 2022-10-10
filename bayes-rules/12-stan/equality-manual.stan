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

transformed parameters {
  array[n] real log_lambda;
  array[n] real<lower=0> lambda;
  
  for (i in 1:n) {
    // We can be super explicit about the whole equation, expanding it to 
    // beta1*x1 + beta2*x2 + ..., or alternatively, we can use dot_product() to 
    // multiply all the betas and Xs at once
    log_lambda[i] = alpha + beta[1] * X[i,1] + beta[2] * X[i,2] + beta[3] * X[i,3];
    // log_lambda[i] = alpha + dot_product(X[i], beta);
    
    lambda[i] = exp(log_lambda[i]);
  }
}

model {
  alpha ~ normal(2, 0.5);
  beta[1] ~ student_t(2, 0, 1);
  beta[2] ~ student_t(2, -0.5, 2);
  beta[3] ~ student_t(2, 0, 2);
  
  Y ~ poisson(lambda);
}

generated quantities {
  array[n] int Y_rep;
  vector[n] log_lik;
  
  for (i in 1:n) {
    log_lik[i] = poisson_lpmf(Y[i] | lambda[i]);
    Y_rep[i] = poisson_rng(lambda[i]);
  }
}
