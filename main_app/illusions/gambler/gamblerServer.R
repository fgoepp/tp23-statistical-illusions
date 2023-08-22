gamblerServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    library(shinyjs)
    # for round i believe
    library(scales)

    observeEvent(input$reset_to_fairness, {
      updateSliderInput(session, "likeliness_fair", value = 100)
    })


    # converts likeliness input
    likeliness <- reactive({
      input$likeliness_fair / 100
    })

    # changes depending on selected experiment
    p0_probability <- reactive({
      if (input$experiment_selector == "Sixes for a dice") {
        (1 / 6)
      } else if (input$experiment_selector == "Heads for a coin") {
        (0.5)
      }
    })

    # helper variable to make calculation more intuitive
    posterior_0_times_prob <- reactive({
      likeliness() * (p0_probability()^(input$streak_length))
    })

    posterior_1_times_prob <- reactive({
      (1 - likeliness()) * ((input$second_prior_probability / 100)^(input$streak_length))
    })

    # calculate and round to make them more easily readable
    posterior_0 <- reactive({
      # catching the case if h1 probability is 0 and we are sure that the event is unfair
      if (posterior_0_times_prob() == 0 && posterior_1_times_prob() == 0) {
        0
      } else {
        round((posterior_0_times_prob()) / (posterior_0_times_prob() + posterior_1_times_prob()), digits = 5)
      }
    })

    posterior_1 <- reactive({
      if (posterior_0_times_prob() == 0 && posterior_1_times_prob() == 0) {
        0
      } else {
        round((posterior_1_times_prob()) / (posterior_1_times_prob() + posterior_0_times_prob()), digits = 5)
      }
    })

    # to prevent display of 0 or 1
    posterior_0_useable <- reactive({
      if (posterior_0() == 0 && !(posterior_0_times_prob() == 0) && !(posterior_1_times_prob() == 1)) {
        0.00001
      } else {
        if (posterior_0() == 1 && !(posterior_0_times_prob() == 1) && !(posterior_1_times_prob() == 0)) {
          0.99999
        } else {
          posterior_0()
        }
      }
    })

    posterior_1_useable <- reactive({
      if (posterior_1() == 0 && !(posterior_1_times_prob() == 0) && !(posterior_0_times_prob() == 1)) {
        0.00001
      } else {
        if (posterior_1() == 1 && !(posterior_1_times_prob() == 1) && !(posterior_0_times_prob() == 0)) {
          0.99999
        } else {
          posterior_1()
        }
      }
    })

    # Plotting the Data in ggplot2
    output$prior_plot <- renderPlot({
      # Creating the Data
      prior_ID <- c(c(1, 1), c(2, 2))

      prior <- c(c(
        "p0", "p1"
      ), c("p0", "p1"))

      prior_situations <- c(
        c(
          "prior odds", "prior odds"
        ),
        c(
          "posterior odds", "posterior odds"
        )
      )

      prior_odds <- c(
        c(likeliness(), (1 - likeliness())), c(posterior_0_useable(), posterior_1_useable())
      )

      # Passing the Data to DataFrame
      prior_Data <- data.frame(prior_situations, prior, prior_odds, prior_ID)
      ######
      ggplot(prior_Data, aes(
        x = reorder(prior_situations, +prior_ID), y = prior_odds,
        fill = prior, label = prior_odds
      ), ylim = 1) +
        ylab("probability") +
        xlab("likelihoods of the hypotheses") +
        geom_bar(stat = "identity") +
        geom_text(
          size = 3, position = position_stack(vjust = 0.5)
        )
    })

    # outputs the scientific notation and a short disclaimer, that the value has been rounded in the plot
    output$rounded_to_0_txt <- renderText(
      if (posterior_0() == 0 && posterior_1() == 0) {
        paste(
          "We shouldn't assume that the second hypothesis is 100% correct, because a 0% probability contradicts the observed events.",
          "But we should also refrain from believing in the first ('fair') hypothesis, since we are 100% sure, that it isn't correct.",
          sep = "\n"
        )
      } else {
        if (posterior_0() == 0 && !(posterior_0_times_prob() == 0)) {
          paste("The posterior value for the 'fair'-hypothesis has been rounded from approximately:", scientific(((posterior_0_times_prob()) / (posterior_0_times_prob() + posterior_1_times_prob())), digits = 5))
        } else if (posterior_1() == 0 && !(posterior_1_times_prob() == 0)) {
          paste("The posterior value for the second hypothesis has been rounded from approximately:", scientific(((posterior_1_times_prob()) / (posterior_1_times_prob() + posterior_0_times_prob())), digits = 5))
        }
      }
    )
  })
}
