
library(shiny)
library(caret)
library("cluster")



shinyServer(function(input, output) {
data(mtcars)  
##Model to train the lm funtion for MPG        
model3 <- lm(mpg ~ cyl + hp + am  + gear, mtcars)
     mtcars_up<-mtcars
 ##Dataset on required Attributes only
     varlab<-c("mpg" , "cyl" , "hp", "am", "gear")
     mtcars_up2<-mtcars_up[varlab]
     

    
     
##Reactive function to Predict the MPG from already trained model        
       pred<-reactive({ 
               Input_Am<-0           
     Input_Cyl<-input$Cyl
     if(input$Trans =="MT") 
     {Input_Am<-1}
     
     Input_Hp<-as.numeric( input$Hp)
     Input_Gears<-input$Gears
     Input_Gears
                
    predict(model3,newdata=data.frame(cyl=Input_Cyl,hp=Input_Hp, am=Input_Am ,gear=Input_Gears ))
                
  
             
     })
     
       ##Reactive function to perform KNN clustering based on The features as inputs
       ## find matching cluster based on slected features and Return all cars part of it.
       car_name<-reactive({ 
               t_mpg<-pred()  
               t_am<-0
               t_cyl<-input$Cyl
               if(input$Trans =="MT") 
               {t_am<-1}
               
               t_hp<-as.numeric( input$Hp)
               t_gear<-input$Gears
               
               
               mtcars_up2[nrow(mtcars_up2)+1, ] =c(t_mpg,t_cyl,t_hp,t_am,t_gear)
               ##mtcars_up2$Cars<-as.factor( mtcars_up2$Cars)   
               # K-Means Cluster Analysis
               fit <- kmeans(mtcars_up2, 5,nstart = 200) # 5 cluster solution
               # append cluster assignment
               mydatax <- data.frame(mtcars_up2, fit$cluster)
               
               row.names(mydatax[mydatax$fit.cluster==unique(mydatax[mydatax$mpg==t_mpg & mydatax$cyl==t_cyl & mydatax$hp==t_hp & mydatax$am==t_am & mydatax$gear==t_gear,6]),])
               
       })       
     
  
        output$prediction<-renderText({pred()})
        
        output$cars<-renderText({car_name()})
   
   
  
})
