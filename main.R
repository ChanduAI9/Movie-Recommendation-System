# Install necessary packages
install.packages("data.table")
install.packages("dplyr")
install.packages("tidyr")
install.packages("recommenderlab")
install.packages("shiny")

# Load libraries
library(data.table)
library(dplyr)
library(tidyr)
library(recommenderlab)
library(shiny)

# Data Preprocessing
preprocess_data <- function(file_path) {
  dataset <- fread(file_path) %>%
    distinct() %>%
    na.omit() %>%
    select(userId, movieId, rating, genres)
  
  # Normalize ratings
  dataset$rating <- (dataset$rating - min(dataset$rating)) / 
                    (max(dataset$rating) - min(dataset$rating))
  
  # Average ratings by userId and movieId
  dataset <- dataset %>%
    group_by(userId, movieId) %>%
    summarize(rating = mean(rating, na.rm = TRUE), .groups = "drop")
  
  return(dataset)
}

create_rating_matrix <- function(dataset) {
  # Convert dataset to user-item matrix
  rating_matrix <- dataset %>%
    pivot_wider(names_from = movieId, values_from = rating, values_fill = list(rating = NA))
  rownames(rating_matrix) <- rating_matrix$userId
  rating_matrix <- rating_matrix %>% select(-userId)
  return(as(as.matrix(rating_matrix), "realRatingMatrix"))
}

# Recommendation Scoring Function
calculate_score <- function(input_list, actual_movies, recommended_movies) {
  common_input_actual <- intersect(input_list, actual_movies)
  common_recommended_actual <- intersect(recommended_movies, actual_movies)
  score <- (length(common_recommended_actual) - length(common_input_actual)) / 3
  return(score)
}

# Build Shiny App
ui <- fluidPage(
  titlePanel("Movie Recommendation System"),
  sidebarLayout(
    sidebarPanel(
      textInput("input_movies", "Enter Previously Watched Movies (comma-separated IDs):"),
      numericInput("user_id", "Enter User ID:", value = 1, min = 1),
      actionButton("recommend", "Get Recommendations")
    ),
    mainPanel(
      tableOutput("recommendations"),
      tags$div(
        "Note: Ensure the User ID and movie IDs exist in the dataset.",
        style = "color: gray; margin-top: 10px;"
      )
    )
  )
)

server <- function(input, output) {
  dataset <- reactive({
    preprocess_data("C:\\Users\\HP\\Downloads\\merged_data_final.csv")
  })
  
  rating_matrix <- reactive({
    create_rating_matrix(dataset())
  })
  
  recommendation_model <- reactive({
    Recommender(rating_matrix(), method = "UBCF")
  })
  
  observeEvent(input$recommend, {
    user_id <- as.numeric(input$user_id)
    input_movies <- as.numeric(unlist(strsplit(input$input_movies, ",")))
    
    if (user_id > 0 & user_id <= nrow(rating_matrix())) {
      # Generate recommendations
      user_predictions <- predict(
        recommendation_model(),
        rating_matrix()[user_id, , drop = FALSE],
        n = 3
      )
      recommended_movies <- as(user_predictions, "list")[[1]]
      
      # Simulate actual movies (for scoring purposes)
      actual_movies <- colnames(rating_matrix())[!is.na(rating_matrix()[user_id, ])]
      
      # Calculate score
      score <- calculate_score(input_movies, actual_movies, recommended_movies)
      
      # Render recommendations and score
      output$recommendations <- renderTable({
        data.frame(
          Recommended_Movies = recommended_movies,
          Score = score
        )
      })
    } else {
      output$recommendations <- renderTable(data.frame(Error = "Invalid User ID"))
    }
  })
}

# Run the App
shinyApp(ui = ui, server = server)
