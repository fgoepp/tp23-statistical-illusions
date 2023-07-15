library(testthat)
# Calculates one prababilities for distribution one or two
# @param n: number of people (int)
# @param c: number of category (int)
# @param prob_nr: problem/distribution number (string)
# @output is a vector with probabilities for distribution one or two

calculateProbabilityBday <- function(n, c, prob_nr) {
  probabilities <- sapply(1:n, function(i) {
    if (prob_nr == "second_prob") {
      p <- (1 - prod(1 - (0:(i - 1)) / c)) * 100
    }
    if (prob_nr == "first_prob") {
      p <- (1 - ((c - 1) / c)^i) * 100
    }
    p
  })
  probabilities
}

#---------------------------------------------------------------------------------------------
# testing known values second probability (2 or more matches)
test_that("test calculateProbability for n = 23, c = 365, prob_nr = 'second_prob'", {
  expect_true(abs(calculateProbabilityBday(23, 365, "second_prob")[23] - 50.7) < 0.05)
})
test_that("test calculateProbability for n = 30, c = 365, prob_nr = 'second_prob'", {
  expect_true(abs(calculateProbabilityBday(30, 365, "second_prob")[30] - 70.6) < 0.05)
})
test_that("test calculateProbability for n = 10, c = 365, prob_nr = 'second_prob'", {
  expect_true(abs(calculateProbabilityBday(10, 365, "second_prob")[10] - 11.7) < 0.05)
})
# testing 'special' values
# n = 1, c > 1
test_that("test calculateProbability for n = 1, c = 111, prob_nr = 'second_prob'", {
  expect_equal(calculateProbabilityBday(23, 365, "second_prob")[1], 0)
})
# n = c = 1
test_that("test calculateProbability for n = 1, c = 1, prob_nr = 'second_prob'", {
  expect_equal(calculateProbabilityBday(1, 1, "second_prob")[1], 0)
})
# n > 1, c = 1
test_that("test calculateProbability for n = 4, c = 1, prob_nr = 'second_prob'", {
  expect_equal(calculateProbabilityBday(4, 1, "second_prob")[4], 100)
})
# n > c
test_that("test calculateProbability for n = 366, c = 365, prob_nr = 'second_prob'", {
  expect_equal(calculateProbabilityBday(366, 365, "second_prob")[366], 100)
})

#---------------------------------------------------------------------------------------------
# testing known values frist probability(same bday as you)
test_that("test calculateProbability for n = 253, c = 365, prob_nr = 'first_prob'", {
  expect_true(abs(calculateProbabilityBday(253, 365, "first_prob")[253] - 50) < 0.05)
})
test_that("test calculateProbability for n = 200, c = 400, prob_nr = 'first_prob'", {
  expect_true(abs(calculateProbabilityBday(200, 400, "first_prob")[200] - 39.3849) < 0.05)
})
# testing 'special' values
# n = 1, c = 365
test_that("test calculateProbability for n = 1, c = 365, prob_nr = 'first_prob'", {
  expect_true(abs(calculateProbabilityBday(1, 365, "first_prob")[1] - 0.2740) < 0.05)
})
# n = c = 1
test_that("test calculateProbability for n = 1, c = 1, prob_nr = 'first_prob'", {
  expect_equal(calculateProbabilityBday(1, 1, "first_prob")[1], 100)
})
# c = 1, n beliebig
test_that("test calculateProbability for n = 200, c = 1, prob_nr = 'first_prob'", {
  expect_equal(calculateProbabilityBday(200, 1, "first_prob")[200], 100)
})
#---------------------------------------------------------------------------------------------

# Calculates the number of people with the given probability, category and problem number
# @param P: probability (float)
# @param c: number of category (int)
# @param prob_nr: problem/distribution number (string)
# @output is the number of people (rounded to the nearest integer) for the given probability, category and problem number

calculateNBday <- function(P, c, prob_nr) {
  if (prob_nr == "first_prob") {
    n <- (log(-P + 1)) / log((c - 1) / c) # (same bday as you)
  }
  if (prob_nr == "second_prob") {
    n <- (1 + sqrt(1 - 4 * (-2) * ((log(-P + 1)) / log((c - 1) / c)))) / 2 # (2 or more matches)
  }
  round(n) # round to nearest integer
}
#---------------------------------------------------------------------------------------------
test_that("calculateNBday calculates the number of people correctly for known inputs", {
  # Test case 1: Same birthday as you
  expect_equal(calculateNBday(0, 365, "first_prob"), 0)
  expect_equal(calculateNBday(0.7, 365, "first_prob"), 439)

  # Test case 2: Classic birthday problem (2 or more matches)
  expect_equal(calculateNBday(0.5, 365, "second_prob"), 23)
  expect_equal(calculateNBday(0, 365, "second_prob"), 1)
})


# just returns legend for guess state
getLegendBeginning <- function() {
  return(legend("topleft",
    inset = 0.01,
    pch = c(15, 15, 19, 4, 19, 4),
    col = c("darkgrey", "lightgrey", "darkgreen", "darkgreen", "darkblue", "darkblue"),
    legend = c(
      "distribution first problem", "distribution second problem",
      "probability question one", "first guess", "probability question two", "second guess"
    ),
    text.col = c("black", "black", "darkgreen", "darkgreen", "darkblue", "darkblue")
  ))
}
# just returns legend for playing state
getLegendPlaying <- function() {
  return(legend("topleft",
    inset = 0.01,
    pch = c(15, 15),
    col = c("darkgrey", "lightgrey"),
    legend = c(
      "distribution first problem", "distribution second problem"
    ),
    text.col = c("black", "black")
  ))
}
