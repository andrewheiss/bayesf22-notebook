``` r
# Make it so Stan chunks in Rmd files use cmdstanr instead of rstan
# This works when knitting, but not when running RStudio interactively
# register_knitr_engine()

# See ?register_knitr_engine for more on how to make it work interactively
#
# For interactive work, we can use override = FALSE and then specify engine =
# "cmdstan" in the stan chunk options
register_knitr_engine(override = FALSE)
```
