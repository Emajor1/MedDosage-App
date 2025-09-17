library(shiny)

# Standard dosage per kg for each drug
dosage_table <- data.frame(
  drug = c("Paracetamol", "Ibuprofen", "Amoxicillin"),
  dose_mg_per_kg = c(15, 10, 20)
)

shinyServer(function(input, output) {
  
  calc_dose <- reactive({
    weight_kg <- input$weight * 0.453592  # Convert lbs to kg
    selected <- dosage_table[dosage_table$drug == input$drug, ]
    dose_mg <- selected$dose_mg_per_kg * weight_kg
    
    freq_map <- c("Once a day" = 1, "Twice a day" = 2, "Three times a day" = 3)
    dose_per_admin <- dose_mg / freq_map[input$frequency]
    dose_mL <- dose_per_admin / input$concentration
    
    list(
      total_mg = round(dose_mg, 2),
      per_admin_mg = round(dose_per_admin, 2),
      per_admin_mL = round(dose_mL, 2)
    )
  })
  
  output$doseText <- renderText({
    dose <- calc_dose()
    paste0("Total Daily Dose: ", dose$total_mg, " mg\n",
           "Dose per Administration: ", dose$per_admin_mg, " mg\n",
           "Volume per Dose: ", dose$per_admin_mL, " mL")
  })
  
  output$dosePlot <- renderPlot({
    dose <- calc_dose()
    barplot(
      c(dose$total_mg, dose$per_admin_mg),
      names.arg = c("Total Daily Dose", "Per Administration"),
      col = c("skyblue", "lightgreen"),
      ylim = c(0, max(2000, dose$total_mg)),
      main = paste("Dosage for", input$drug),
      ylab = "Dose (mg)"
    )
  })
})
