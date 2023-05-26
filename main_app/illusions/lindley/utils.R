# Create binomial distributed data
# @param n: Sample size (Number of trials).
# @param p: Probability of success.
create_data <- function(n, p) {
  data <- rbinom(1000, size = n, prob = p)
  data
}

# Calculate bayes factor with H0 binomial and H1 uniform
# @param data: Binomial distributed data.
# @param H0_p: The p chosen by the user.
get_unif_bayes_decision <- function(data, H0_p) {
  
}


# Calculates frequentist approach with one sided binomial test for H0
# @param data: Binomial distributed data.
# @param H0_p: The p chosen by the user.
# @param significance_level: The significance level chosen by the user.
get_frequentist_decision <- function(data, H0_p, significance_level) {

  
}
