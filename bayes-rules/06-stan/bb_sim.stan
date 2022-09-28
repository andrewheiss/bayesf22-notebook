// Step 1: Define the model
// Stuff from R
data {
  int<lower=0, upper=10> Y;
}

// Thing to estimate
parameters {
  real<lower=0, upper=1> pi;
}

// Prior and likelihood
model {
  Y ~ binomial(10, pi);
  pi ~ beta(2, 2);
}
