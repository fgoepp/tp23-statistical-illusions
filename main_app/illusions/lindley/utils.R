library(testthat)

# For testing purposes create function to create known data
create_test_data <- function(n, hits) {
  # Create a vector with the required number of 1s and 0s
  data_vector <- c(rep(1, hits), rep(0, n - hits))
  data_vector
}

# Testing function create_test_data
#-----------------------------------------
test_that("create_test_data: 0 hits for", {
  expect_equal(create_test_data(3, 0), c(0, 0, 0))
})
test_that("create_test_data: 1 hits for", {
  expect_equal(create_test_data(2, 2), c(1, 1))
})
test_that("create_test_data: number of hits", {
  expect_equal(create_test_data(3, 1), c(1, 0, 0))
})
#-----------------------------------------

create_data <- function(n, p) {
  # Create a vector with the required number of 1s and 0s
  hits <- n * p
  data_vector <- c(rep(1, hits), rep(0, n - hits))
  data_vector
}

# Count the hits for binomial distributed data
# @param data: binomially distributed data
hits_data <- function(data) {
  hits <- sum(data == 1)
  hits
}

# Testing function hits_data
#-----------------------------------------
test_that("hits_data: number of hits", {
  expect_equal(hits_data(create_test_data(69, 42)), 42)
})
#-----------------------------------------

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
    decision <- paste("Baysian: H₀ more likely -> keep H₀ ", "P(H₀) ", p_H0_k)
    green_color <- TRUE
  } else {
    decision <- paste("Baysian: H₁ more likely -> reject H₀ ", "P(H₀) ", p_H0_k)
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

# Testing function get_bayes_decision
#-----------------------------------------
test_that("get_bayes_decision: reject when large disparity ", {
  expect_false(as.logical(get_bayes_decision(create_test_data(69, 1), 0.99, TRUE)[1]))
})
test_that("get_bayes_decision: accept when very similar", {
  expect_true(as.logical(get_bayes_decision(create_test_data(100, 50), 0.5, TRUE)[1]))
})

test_that("get_bayes_decision: uninfo reject when large disparity ", {
  expect_false(as.logical(get_bayes_decision(create_test_data(69, 69), 0.1, FALSE)[1]))
})
test_that("get_bayes_decision: uninfo accept when H0 covers data", {
  expect_true(as.logical(get_bayes_decision(create_test_data(100, 50), 0.99, FALSE)[1]))
})
#-----------------------------------------


# Testing function get_H0_bayes
#-----------------------------------------
test_that("get_H0_bayes: 0 when large disparity ", {
  expect_equal(as.numeric(get_H0_bayes(create_test_data(69, 1), 1, TRUE)[1]), 0)
})
test_that("get_H0_bayes: > 0.5 when very similar", {
  expect_true(get_H0_bayes(create_test_data(100, 50), 0.5, TRUE)[1] > 0.5)
})

test_that("get_H0_bayes: 0 when large disparity ", {
  expect_equal(as.numeric(get_H0_bayes(create_test_data(69, 68), 0.001, FALSE)[1]), 0)
})
test_that("get_H0_bayes: > 0.5 when very similar", {
  expect_true(get_H0_bayes(create_test_data(100, 50), 0.99, FALSE)[1] > 0.5)
})

#-----------------------------------------

# Calculates frequentist approach with two sided binomial test for H0
# @param data: Binomial distributed data.
# @param H0_p: The p chosen by the user.
# @param significance_level: The significance level chosen by the user.
# @output is a tuple with a boolean for text coloring and the fitting outputtext
get_frequentist_decision <- function(data, H0_p, significance_level) {
  # how many hits there actually are
  Tx <- hits_data(data)
  n <- length(data)

  # central limit theorem
  # calculate p-value
  p_val <- round(2 * (1 - pnorm(abs((Tx - n * H0_p) / sqrt(n * H0_p * (1 - H0_p))), mean = 0, sd = 1)), digits = 2)

  decision <- ""

  green_color <- FALSE

  if (p_val < significance_level) {
    decision <- paste("Frequentist: H₀ significant rejected ", "p_val ", p_val, " < ", significance_level, " significance level")
  } else {
    decision <- paste("Frequentist: No significant rejection of H₀ ", "p_val ", p_val, " > ", significance_level, " significance level")
    green_color <- TRUE
  }

  c(green_color, decision)
}

# Testing function get_frequentist_decision
#-----------------------------------------
test_that("get_frequentist_decision: reject when large disparity ", {
  expect_false(as.logical(get_frequentist_decision(create_test_data(69, 0), 0.99, TRUE)[1]))
})
test_that("get_frequentist_decision: accept when very similar", {
  expect_true(as.logical(get_frequentist_decision(create_test_data(100, 50), 0.5, TRUE)[1]))
})

#-----------------------------------------


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


  # H1 is uniform
  H1_plot <- dunif(x, min = 0, max = n)

  plot(x, y_H0, type = "l", ylim = c(0, max(y_H0)), xlab = "x", ylab = "Density", col = "red")

  # Plot H1
  lines(x, H1_plot, col = "green", lwd = 2)

  # Plot the data
  data_x <- c(hits_data(data), hits_data(data))
  data_y <- c(0, 1)
  lines(data_x, data_y, col = "grey", lwd = 2)

  # Add points representing the data where it crosses both distributions
  data_x <- hits_data(data)
  data_y_norm <- dnorm(data_x, mean = normal[2], sd = normal[3])
  data_y_unif <- dunif(data_x, min = 0, max = n)
  points(data_x, data_y_norm, col = "purple", pch = 16)
  points(data_x, data_y_unif, col = "purple", pch = 16)

  # add explanation of distributions
  legend("topleft",
    legend = c(
      "Actual data",
      bquote("Predicted by H"[0]),
      bquote("H"[1] ~ "of Bayesian")
    ),
    col = c("grey", "red", "green"), lwd = 1
  )
}

plot_distributions_uninfo <- function(n, p, data, H0_p) {
  # specify what x-Axis
  x <- round(seq(0, n, length.out = 1000))

  # H0 uniform to H0_p
  H_plot <- dunif(x, min = 0, max = n)

  plot(x, H_plot, type = "l", ylim = c(0, max(H_plot) * 10), xlab = "x", ylab = "Density", col = "red")

  # Define the start and end positions of the line
  start <- c(H0_p * n, 0)
  end <- c(H0_p * n, max(H_plot))

  # Draw the perpendicular line
  lines(c(start[1], end[1]), c(start[2], end[2]), col = "green", lwd = 5)

  # Plot the data
  data_x <- c(hits_data(data), hits_data(data))
  data_y <- c(0, 1)
  lines(data_x, data_y, col = "grey", lwd = 2)

  # Add points representing the data where it crosses both distributions
  data_x <- hits_data(data)
  data_y_unif <- dunif(data_x, min = 0, max = n)
  points(data_x, data_y_unif, col = "purple", pch = 16)

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
