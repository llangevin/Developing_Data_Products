library(shiny)
library(ggplot2)

#data used in the application
#mtcars: Motor Trend Car Road Tests
mtcars$cyl<-as.factor(mtcars$cyl)
mtcars$vs<-as.factor(mtcars$vs)
mtcars$am<-as.factor(mtcars$am)
mtcars$gear<-as.factor(mtcars$gear)
mtcars$carb<-as.factor(mtcars$carb)
#data <- mtcars

shinyServer(
  function(input, output) {
    # Create a reactive text for the graph title
    text <- reactive({
      if (input$factor == "none") {
        paste('Miles/(US) gallon (mpg) versus', input$xcol)
      } else if (input$int != TRUE){
        paste('Miles/(US) gallon (mpg) versus', input$xcol, 'and', input$factor)
      } else {
        paste('Miles/(US) gallon (mpg) versus', input$xcol, 'and', input$factor, 'with interaction')
      }
    })
    
    # Return as text the selected variables
    output$caption <- renderText({
      text()
    })
    
    #Generation of the plot
    output$plot_mpg_x <- renderPlot({
        data <- mtcars
#        p <- ggplot(data, aes_string(x=input$xcol,y="mpg")) 
      if (input$factor == "none") {
        mod<-lm(as.formula(paste("mpg ~ ", paste(input$xcol))), data=data)
        data<-cbind(data,predict(mod,interval="confidence"))
        p<-ggplot(data, aes_string(x=input$xcol,y="mpg")) + geom_point() + geom_line(aes(y=fit))
      } else if (input$int != TRUE) {
        mod<-lm(as.formula(paste("mpg ~ ", paste(input$xcol),"+",paste(input$factor))), data=data)
        data<-cbind(data,predict(mod,interval="confidence"))
        p<-ggplot(data, aes_string(x=input$xcol,y="mpg",colour=input$factor)) + geom_point(mapping=aes_string(colour=input$factor)) +geom_line(aes(y=fit))
      } else {
        mod<-lm(as.formula(paste("mpg ~ ", paste(input$xcol),"*",paste(input$factor))), data=data)
        data<-cbind(data,predict(mod,interval="confidence"))
        p<-ggplot(data, aes_string(x=input$xcol,y="mpg",colour=input$factor)) + geom_point(mapping=aes_string(colour=input$factor)) +geom_line(aes(y=fit))
      }
      if (input$ci == TRUE) {
        p<- p +geom_ribbon(aes(ymin=lwr,ymax=upr),alpha=0.25)
      }
      print(p)
    })
    
    #Fit of the model
    output$summary <- renderPrint({
      if (input$factor == "none") {
        modelfit<-lm(as.formula(paste("mpg ~ ", paste(input$xcol))), data=mtcars)
      } else if (input$int != TRUE) {
        modelfit<-lm(as.formula(paste("mpg ~ ", paste(input$xcol),"+",paste(input$factor))), data=mtcars)
      } else {
        modelfit<-lm(as.formula(paste("mpg ~ ", paste(input$xcol),"*",paste(input$factor))), data=mtcars)
      }
      summary(modelfit)
    })
  }
)