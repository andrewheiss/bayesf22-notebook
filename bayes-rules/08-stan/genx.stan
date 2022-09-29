// Things coming in from R
data {
  int<lower=0> artworks;
  int<lower=0> num_genx;
}

// Thing to estimate
parameters {
  real<lower=0, upper=1> pi;  // Proportion of Gen X artists
}

// Prior and likelihood
model {
  // Prior
  pi ~ beta(4, 6);
  
  // Likelihood
  num_genx ~ binomial(artworks, pi);
}
