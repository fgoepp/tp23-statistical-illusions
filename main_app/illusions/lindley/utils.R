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
get_bayes_decision <- function(data, H0_p, uninfo) {
  # calculate p_H0_k depending on priors
  p_H0_k <- get_H0_bayes(data, H0_p, uninfo)

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
get_H0_bayes <- function(data, H0_p, uninfo) {
  p_H0_k <- -1

  n <- length(data)
  # how many hits there actually are
  k <- hits_data(data)

  if (uninfo == TRUE) {
    p_k_H0 <- choose(n, k) * H0_p^k * (1 - H0_p)^(n - k)
    p_k_H1 <- 1 / (n + 1)

    # 0,5 because prior the alternatives are set to be equal
    p_H0_k <- (p_k_H0 * 0.5) / (p_k_H0 * 0.5 + p_k_H1 * 0.5)
  } else {
    # for both uniform
    p_H0_k <- pbeta(H0_p, k + 1, n - k + 1) - pbeta(0, k + 1, n - k + 1)
  }
  # round values
  p_H0_k <- round(p_H0_k, digits = 2)
  # return p_H0_k
  p_H0_k
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

plot_distributions <- function(n, p, data, H0_p, uninfo) {
  if (uninfo == TRUE) {
    return(plot_distributions_normal(n, p, data, H0_p))
  } else {
    return(plot_distributions_uninfo(n, p, data, H0_p))
  }
}

plot_distributions_normal <- function(n, p, data, H0_p) {
  # specify what x-Axis
  x <- round(seq(0, n, length.out = 1000))
  # load normal dist
  normal <- calc_normal_dist(data, H0_p)

  # H0 is normal
  y_H0 <- dnorm(x, mean = normal[2], sd = normal[3])

  # plot the data
  x_binomial <- 0:n
  y_binomial <- dbinom(x_binomial, size = n, prob = p)

  # H1 is uniform
  H1_plot <- dunif(x, min = 0, max = n)

  plot(x, y_H0, type = "l", ylim = c(0, max(y_H0, y_binomial)), xlab = "x", ylab = "Density", col = "red")

  # Plot H1
  lines(x, H1_plot, col = "green", lwd = 2)

  # Plot the binomial distribution
  points(x_binomial, y_binomial, col = "blue")

  # add explanation of distributions
  legend("topleft",
    legend = c(
      "Actual data",
      bquote("Predicted by H"[0]),
      bquote("H"[1] ~ "of Bayesian")
    ),
    col = c("blue", "red", "green"), lwd = 1
  )
}

plot_distributions_uninfo <- function(n, p, data, H0_p) {
  # specify what x-Axis
  x <- round(seq(0, n, length.out = 1000))

  # plot the data
  y_binomial <- dbinom(x, size = n, prob = p)

  # H0 uniform to H0_p
  H_plot <- dunif(x, min = 0, max = n)

  # plot the data
  x_binomial <- 0:n
  y_binomial <- dbinom(x_binomial, size = n, prob = p)

  plot(x, H_plot, type = "l", ylim = c(0, max(H_plot, y_binomial)), xlab = "x", ylab = "Density", col = "red")

  # Define the start and end positions of the line
  start <- c(H0_p * n, 0)
  end <- c(H0_p * n, max(H_plot))

  # Draw the perpendicular line
  lines(c(start[1], end[1]), c(start[2], end[2]), col = "green", lwd = 5)

  # Plot the binomial distribution
  points(x_binomial, y_binomial, col = "blue")

  # add explanation of distributions
  legend("topleft",
    legend = c(
      "Actual data",
      bquote("Predicted by H"[0]),
      bquote("H"[1] ~ "of Bayesian")
    ),
    col = c("blue", "red", "green"), lwd = 1
  )
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
