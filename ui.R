shinyUI(pageWithSidebar(
  headerPanel("MPG regression of mtcars data visualization tool"),
  sidebarPanel(
    #Widgets definition
    selectInput('xcol', 'X Variable', list("Displacement (cu.in.)" = "disp",
                                           "Rear axle ratio"  = "drat",
                                           "Weight (lb/1000)" = "wt",
                                           "1/4 mile time"  = "qsec")),
    
    checkboxInput(inputId = "ci",
                  label = strong("Show 95% level of confidence interval"),
                  value = FALSE),
    
    selectInput('factor', 'Factor Variable', list("None" = "none",
                                                "Number of cylinders" = "cyl",
                                                "V/S"  = "vs",
                                                "Transmission (0 = automatic, 1 = manual)" = "am",
                                                "Number of forward gears"  = "gear",
                                                "Number of carburetors"  = "carb")),
    
    # Display this only if the density is shown
    conditionalPanel(condition = ("input.factor != 'none'"),
                     checkboxInput(inputId = "int",
                                   label = strong("Interaction between X and Factor variables"),
                                   value = FALSE)),

    hr(),
    helpText("A Shiny interactive visualization tool to help the students from the Regression Models Course in their final project.",
             "They are interested in exploring the relationship between a set of variables (mtcars data) and miles per gallon (MPG) (outcome)."),
    helpText("With this Shiny application it is possible to visualize the relationship between MPG and any other continuous variable in a scatter plot",
             "along with the fitted regression straight line by selecting it in the 'X variable' section. To obtain a confidence interval with the fitted line simply check",
             "the 'Show 95% level of confidence interval' box."),
    helpText("It is possible to add a factor variable to the relation by selecting it in the 'Factor Variable' section.",
             "A model containing the continuous and factor variables is fitted, so a regression line is drawn for each factor level (same slope and different intercepts)."),
    helpText("To considere an interaction term in the model, check the 'Interaction between X and Factor variables' that appear when a factor variable is selected.",
             "then a regression line is drawn for each factor level with his own slope and intercept."),
    helpText("Finally, a summary of the corresponding selected model is automatically printed in the 'ANOVA Table' section.")
    
  ),
  #Printing of the results
  mainPanel(
    h3(textOutput("caption")),
    plotOutput('plot_mpg_x'),
    h3("ANOVA Table"),
    verbatimTextOutput("summary")
  )
))