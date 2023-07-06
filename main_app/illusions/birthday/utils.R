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

calculateNBday <- function(P, c, prob_nr) {
  if (prob_nr == "first_prob") {
    n <- (log(-P + 1)) / log((c - 1) / c) # same bday as you
  }
  if (prob_nr == "second_prob") {
    n <- (1 + sqrt(1 - 4 * (-2) * ((log(-P + 1)) / log((c - 1) / c)))) / 2 # classic bday problem (2 matches)
  }
  round(n) # round to nearest integer
}


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
