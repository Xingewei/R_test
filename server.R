#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny);
library(plotly);
library(DT);

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    # get cars data;
    data(mtcars)
    fit1<-lm(mpg~hp+am, data=mtcars)
    pred<-reactive({
        ehp<-input$HP
        eam<-ifelse(input$auto,1,0)
        predict(fit1,newdata=data.frame(hp=ehp,am=eam))
    })
    
    output$plot1 <- renderPlot({

        plot(x=mtcars$hp, y=mtcars$mpg,pch=16, col=as.factor(mtcars$am+1), xlab='Horse power',ylab='Miles Per Garlon') 
         abline(fit1,col='blue',lwd=2)
         points(x=input$HP,y=pred(),col='green', pch=19,size=16)
         legend("topright", c("Auto","Manu"),pch=16,  col = c(1,2))
                    
    })
    

    output$data<- DT::renderDataTable({
        DT::datatable(mtcars)
    })
      
    output$plot<-renderPlot({
        ggplot(data=mtcars,aes(x=hp,y=mpg))+
            geom_point()+
            facet_grid(.~am)+
            geom_smooth(method = "lm")+
            labs(x="Horse power",y="Miles per garlon")
    })
     
    
    output$pmpg<-renderText({
        pred()
    })
})
