library(shiny)

shinyUI(fluidPage(
  titlePanel("💊 Medication Dosage Calculator"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("weight", "Patient Weight (lbs):", value = 154, min = 30, max = 400),
      numericInput("age", "Patient Age (years):", value = 30, min = 0, max = 120),
      radioButtons("gender", "Gender:", choices = c("Male", "Female", "Other")),
      selectInput("drug", "Select Medication:",
                  choices = c("Paracetamol", "Ibuprofen", "Amoxicillin")),
      selectInput("frequency", "Dose Frequency:",
                  choices = c("Once a day", "Twice a day", "Three times a day")),
      numericInput("concentration", "Drug Concentration (mg/mL):", value = 5, min = 1, max = 100),
      helpText("Enter patient details to calculate dosage. All calculations are based on standard weight-based dosing.")
    ),
    
    mainPanel(
      h3("Dosage Summary"),
      verbatimTextOutput("doseText"),
      plotOutput("dosePlot")
    )
  )
))
