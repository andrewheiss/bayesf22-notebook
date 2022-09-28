// Step 1: Define the model
// Stuff from R
data {
  array[2] int Y;
}

// Thing to estimate
parameters {
  real<lower=0, upper=15> lambda;
}

// Prior and likelihood
model {
  Y ~ poisson(lambda);
  lambda ~ gamma(3, 1);
}
