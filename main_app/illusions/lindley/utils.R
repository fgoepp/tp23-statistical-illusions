# Create binomial distributed data
# @param n: Sample size (Number of trials).
# @param p: Probability of success.
create_data <- function(n, p) {
  data <- rbinom(n, size = 1, prob = p)
  data
}

# Count the hits for binomial distributed data
# @param data: binomially distributed data
hits_data <- function(data) {
  hits <- sum(data[complete.cases(data)] == 1)
  hits
}

# Calculate bayes factor with H0 binomial and H1 uniform
# @param data: Binomial distributed data.
# @param H0_p: The p chosen by the user for H0.
# @param uniform: Boolean to choose type of H1.
# @output is a tuple with a boolean for text coloring and the fitting outputtext.
get_bayes_decision <- function(data, H0_p, uniform) {
  n <- length(data)
  # how many hits there actually are
  k <- hits_data(data)

  p_k_H0 <- choose(n, k) * H0_p^k * (1 - H0_p)^(n - k)
  p_k_H1 <- get_H1_bayes(uniform, length(data), k, H0_p, n)

  # 0,5 because prior the alternatives are set to be equal
  p_H0_k <- round((p_k_H0 * 0.5) / (p_k_H0 * 0.5 + p_k_H1 * 0.5), digits = 2)

  decision <- ""

  green_color <- FALSE

  if (p_H0_k > 0.5) {
    decision <- paste("H₀ more likely ", "P(H₀) ", p_H0_k)
    green_color <- TRUE
  } else {
    decision <- paste("H₁ more likely -> reject H₀ ", "P(H₀) ", p_H0_k)
  }

  c(green_color, decision)
}

# Calculates H1 for bayesian decision
# H1 is either uniform or uniform H1: theta < H0_p depending on user choice
# @param uniform: Boolean to choose type of H1.
# @param count_samples: Is n for the binomial data.
# @param hits: Hits in binomial data.
# @param H0_p: The p chosen by the user for H0.
# @param n: Length of data.
get_H1_bayes <- function(uniform, count_samples, hits, H0_p, n) {
  p_k_H1 <- -1
  if (uniform == TRUE) {
    # for uniform
    p_k_H1 <- 1 / (n + 1)
  } else {
    # for uniform H1: theta < 0,5

    p_k_H1 <- pbeta(1, hits, count_samples - hits) - pbeta(0.5, hits, count_samples - hits)
  }
  p_k_H1
}

# Calculates frequentist approach with one sided binomial test for H0
# @param data: Binomial distributed data.
# @param H0_p: The p chosen by the user.
# @param significance_level: The significance level chosen by the user.
# @output is a tuple with a boolean for text coloring and the fitting outputtext
get_frequentist_decision <- function(data, H0_p, significance_level) {
  # binomial approximated by gauß

  normal <- calc_normal_dist(data, H0_p)
  n <- normal[1]
  mu <- normal[2]
  sigma_sq <- normal[3]

  # how many hits there actually are
  actual <- sum(data[complete.cases(data)] == 1)

  # calculate p-value
  p_val <- round(pnorm(n + 0.5, mean = mu, sd = sigma_sq) - pnorm(actual - 0.5, mean = mu, sd = sigma_sq), digits = 2)

  decision <- ""

  green_color <- FALSE

  if (p_val < significance_level) {
    decision <- paste("H₀ rejected ", "p_val ", p_val, " < ", significance_level, " significance level")
  } else {
    decision <- paste("No significant rejection of H₀ ", "p_val ", p_val, " > ", significance_level, " significance level")
    green_color <- TRUE
  }

  c(green_color, decision)
}

plot_distributions <- function(n, p, data, H0_p, uniform) {
  # specify what x-Axis
  x <- seq(0, n, length.out = 1000)
  # load normal dist
  normal <- calc_normal_dist(data, H0_p)

  y_H0 <- dnorm(x, mean = normal[2], sd = normal[3])

  x_binomial <- 0:n
  y_binomial <- dbinom(x_binomial, size = n, prob = p)

  H1_plot <- get_H1_plot(uniform, x, H0_p, n)

  plot(x, y_H0, type = "l", ylim = c(0, max(y_H0, y_binomial)), xlab = "x", ylab = "Density", col = "red")

  # Plot H1
  lines(x, H1_plot, col = "green", lwd = 2)

  # Plot the binomial distribution
  points(x_binomial, y_binomial, col = "blue")

  # add explanation of distributions
  legend("topleft", legend = c("Actual data", "Predicted by H₀", "H₁ of Bayesian"), col = c("blue", "red", "green"), lwd = 1)
}

get_H1_plot <- function(uniform, x, H0_p, n) {
  H1_plot <- dunif(x, min = 0, max = n)
  if (uniform == FALSE) {
    H1_plot <- dunif(x, min = 0, max = n * H0_p)
  }
  H1_plot
}

# Change binomial into gauß
calc_normal_dist <- function(data, H0_p) {
  # calculate values for gauß
  n <- length(data)
  mu <- n * H0_p
  sigma_sq <- sqrt(n * H0_p * (1 - H0_p))
  vec <- c(n, mu, sigma_sq)
  vec
}
