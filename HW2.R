# Load libraries
library(shiny)
library(ggplot2)
library(dplyr)

# Load dataset
data <- read.csv("/Users/ajayshenoy/Downloads/stat 436/ShinyApp/Cancer_Data.csv")
head(data)

#removing unneeded rows like id and x
data <- data %>%
  select(-id, -X) %>%
  mutate(diagnosis = factor(diagnosis, levels = c("B", "M")))
head(data)

# List of numeric features 
feature_choices <- names(data)[sapply(data, is.numeric)]
feature_choices

# Create a named vector of features with readable labels for better viewability
feature_labels <- c(
  "Mean Radius" = "radius_mean",
  "Mean Texture" = "texture_mean",
  "Mean Perimeter" = "perimeter_mean",
  "Mean Area" = "area_mean",
  "Mean Smoothness" = "smoothness_mean",
  "Mean Compactness" = "compactness_mean",
  "Mean Concavity" = "concavity_mean",
  "Mean Concave Points" = "concave.points_mean",
  "Mean Symmetry" = "symmetry_mean",
  "Mean Fractal Dimension" = "fractal_dimension_mean"
)

#train regression model to predict if B or M
set.seed(123)
model <- glm(diagnosis ~ radius_mean + texture_mean + concavity_mean,
             data = data,
             family = binomial)

# UI
ui <- fluidPage(
  #title
  titlePanel("Breast Cancer Tumor Feature Visualization"),
  
  #sidebar layout to select features to visualize
  #gets the feature and type of tumor
  sidebarLayout(
    sidebarPanel(
      h3("Feature Visualization"),
      selectInput(
        #input for feature to make boxplot
        inputId = "feature",
        label = "Select Feature to Visualize:",
        choices = feature_labels,
        selected = "radius_mean"
      ),
      selectInput(
        #pick what tumor want to see on boxplot
        inputId = "diagnosis_filter",
        label = "Select Diagnosis Filter:",
        choices = c("Both", "Benign (B)", "Malignant (M)"),
        selected = "Both"
      ),
      hr(),
      #input values so can predict the type of tumor
      h3("Predict Tumor Type"),
      numericInput("input_radius", "Radius Mean:", value = 15, min = 5, max = 30),
      numericInput("input_texture", "Texture Mean:", value = 20, min = 5, max = 40),
      numericInput("input_concavity", "Concavity Mean:", value = 0.1, min = 0, max = 1)
    ),
    
    mainPanel(
      plotOutput("featurePlot"),
      textOutput("description"),
      hr(),
      h4("Prediction Result"),
      textOutput("prediction")
    )
  )
)

# Server
server <- function(input, output) {
  
  # Reactive: filter dataset based on tumor selection, filters the boxplot by both, B, or M
  filtered_data <- reactive({
    if (input$diagnosis_filter == "Both") {
      data
    } else if (input$diagnosis_filter == "Benign (B)") {
      filter(data, diagnosis == "B")
    } else {
      filter(data, diagnosis == "M")
    }
  })
  
  # Render plot - boxplot, code to generate the boxplot
  output$featurePlot <- renderPlot({
    ggplot(filtered_data(), aes_string(x = "diagnosis", y = input$feature, fill = "diagnosis")) +
      geom_boxplot(alpha = 0.7) +
      labs(
        title = paste("Distribution of", input$feature, "by Diagnosis"),
        x = "Diagnosis",
        y = input$feature
      ) +
      scale_fill_manual(values = c("B" = "blue", "M" = "red")) +
      theme_minimal() +
      theme(legend.position = "none")
  })
  
  # description text saying what the boxplot means
  output$description <- renderText({
    paste("This plot shows the distribution of", input$feature,
          "across tumor diagnosis types. Red boxes indicate malignant tumors, and blue boxes indicate benign tumors.")
  })
  
  
  # Code to receive inputted radius, texture, concavity and predict if the tumor is B or M
  output$prediction <- renderText({
    new_data <- data.frame(
      radius_mean = input$input_radius,
      texture_mean = input$input_texture,
      concavity_mean = input$input_concavity
    )
    pred_prob <- predict(model, newdata = new_data, type = "response")
    pred_class <- ifelse(pred_prob > 0.5, "Malignant (M)", "Benign (B)")
    paste("Predicted Tumor Type:", pred_class, 
          "(Probability of malignancy:", round(pred_prob, 2), ")")
  })
}

# Run the app
shinyApp(ui = ui, server = server)
