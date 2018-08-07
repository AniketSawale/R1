#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/

#
data <- read.csv(file = "~/Desktop/data1000.csv")
library(h2o)
h2o.init()
dataOrigin <- as.h2o(data)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
 condition <- eventReactive(input$action, {
   #For name
   name <- input$variable
   #for cateogry
   category_name <- input$cat
   if(input$cat == "women")
     subcategory <- input$womensub
   if(input$cat == "men")
     subcategory <- input$mensub
   if(input$cat == "Kids")
     subcategory <- input$Kidsub
   if(input$cat == "Sports")
     subcategory <- input$Sportsub
   if(input$cat == "Electronics")
     subcategory <- input$Elecsub
   if(input$cat == "Beauty")
     subcategory <- input$Beautysub
	 #Pasting category & subcategory
   category_name <- paste(category_name,subcategory,sep = "/")
  #category_name <- paste(category_name,subcategory,sep = "/")
	 #for Brand
   brand_name <- input$Brand
	 #For Shipping
   switch(input$Shipping,
                      "1" = 1,
                      "0" = 0
   )
   shipping <- input$Shipping
	 #For item_description
   item_description <- input$desc
   x = c("name","category_name","brand_name","shipping","item_description")
   y = "item_condition_id"
	 #For codition_id model
   condition_model <- h2o.deeplearning(x,y,dataOrigin)
   datatemp <- cbind(name = name,category_name = category_name,brand_name = brand_name,shipping = shipping,item_description = item_description)
   datatemp <- as.data.frame(datatemp)
   datatemp <- as.h2o(datatemp)
   #datatemp <- h2o.asfactor(datatemp)
   datatemp$shipping <- as.numeric(datatemp$shipping)
   condition_predict <- h2o.predict(condition_model,datatemp)
   condition_predict <- as.numeric(condition_predict)
   #datatemp <- cbind.data.frame(name = name, item_condition_id = condition_predict, category_name = category_name, brand_name = brand_name,shipping = shipping,item_description = item_description)
   condition_predict <- floor(condition_predict)
   return(condition_predict)
   })
 data <- reactive({
   
   #For name
   name <- input$variable
   #for cateogry
   
   category_name <- input$cat
   
   

  if(input$cat == "women")
    subcategory <- input$womensub
   if(input$cat == "men")
     subcategory <- input$mensub
   if(input$cat == "Kids")
     subcategory <- input$Kidsub
   if(input$cat == "Sports")
     subcategory <- input$Sportsub
   if(input$cat == "Electronics")
     subcategory <- input$Elecsub
   if(input$cat == "Beauty")
     subcategory <- input$Beautysub
   category_name <- paste(category_name,subcategory,sep = "/")
    
   #category_name <- paste0(category1,subcategory,collapse = "/")
   
   brand_name <- input$Brand
   switch(input$Shipping,
                      "1" = 1,
                      "0" = 0
   )
   shipping <- input$Shipping
   item_description <- input$desc
   item_condition_id <- condition()
   item_condition_id <- as.data.frame(item_condition_id)
   
   
   x1 = c("name","item_condition_id","category_name","brand_name","shipping","item_description")
   y1 = "price"
   price_model <- h2o.deeplearning(x1,y1,dataOrigin)
   datatemp1 <- cbind(name = name, item_condition_id = item_condition_id, category_name = category_name, brand_name = brand_name,shipping = shipping,item_description = item_description)
   datatemp1 <- as.data.frame(datatemp1)
   #datatemp1 <- apply(datatemp1,2,as.character)
   #datatemp1$item_condition_id <- as.numeric(datatemp1$item_condition_id)
   datatemp1$shipping <- as.numeric(datatemp1$shipping)
   datatemp1 <- as.h2o(datatemp1)
   #datatemp1 <- h2o.asfactor(datatemp1)
   price_predict <- h2o.predict(price_model,datatemp1)
   price <- round(price_predict,digits = 2)
   price <- as.data.frame(price)
   price <- as.numeric(price)
   datatemp2 <- cbind(name = name,item_condition_id = item_condition_id,category_name = category_name,brand_name = brand_name,price = price, shipping = shipping,item_description = item_description)
   datatemp2 <- as.data.frame(datatemp2)
   #data <- rbind(data,datatemp2)
   write.table(datatemp2, file = "~/Desktop/data1000.csv",sep = ",",append = TRUE,row.names = FALSE,col.names = FALSE)
   return(price)
   
   
 })
 output$Prediction <- renderText({
   data()
 })
})