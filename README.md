# Developing_Data_Products  
Developing Data Products Coursera Course  

#MPG regression of mtcars data visualization tool  

A Shiny interactive visualization tool to help the students from the Regression Models Course in their final project. They are interested in exploring the relationship between a set of variables (mtcars data) and miles per gallon (MPG) (outcome).
With this Shiny application it is possible to visualize the relationship between MPG and any other continuous variable in a scatter plot along with the fitted regression straight line by selecting it in the 'X variable' section. To obtain a confidence interval with the fitted line simply check the 'Show 95% level of confidence interval' box.
It is possible to add a factor variable to the relation by selecting it in the 'Factor Variable' section. A model containing the continuous and factor variables is fitted, so a regression line is drawn for each factor level (same slope and different intercepts).
To considere an interaction term in the model, check the 'Interaction between X and Factor variables' that appear when a factor variable is selected. then a regression line is drawn for each factor level with his own slope and intercept.
Finally, a summary of the corresponding selected model is automatically printed in the 'ANOVA Table' section.