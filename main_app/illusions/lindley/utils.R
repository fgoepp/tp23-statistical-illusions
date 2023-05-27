# Create binomial distributed data
# @param n: Sample size (Number of trials).
# @param p: Probability of success.
create_data <- function(n, p) {
  data <- rbinom(n, size = 1, prob = p)
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
  # binomial approximated by gauß

  # calculate values for gauß
  n <- length(data)
  mu <- n * H0_p
  sigma_sq <- sqrt(n * H0_p * (1 - H0_p))

  # how many hits there actually are
  actual <- sum(data[complete.cases(data)] == 1)

  print(paste("n: ", n))
  print(paste("actual: ", actual))
  print(paste("bis n; ", pnorm(n + 0.5, mean = mu, sd = sigma_sq)))
  print(paste("bis actual; ", pnorm(actual - 0.5, mean = mu, sd = sigma_sq)))

  # calculate p-value
  p_val <- pnorm(n + 0.5, mean = mu, sd = sigma_sq) - pnorm(actual - 0.5, mean = mu, sd = sigma_sq)

  decision <- ""

  if (p_val < significance_level) {
    decision <- paste("H0 rejected ", "p_val ", p_val, " < ", significance_level, " significance level")
  } else {
    decision <- paste("No significant rejection of H0 ", "p_val ", p_val, " > ", significance_level, " significance level")
  }

  decision
}
