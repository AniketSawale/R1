#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shiny.semantic)
#dtrain <- read.csv("~/Desktop/train.tsv", header = TRUE, nrows = 10000, header = TRUE, sep = "\t", quote = "")
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Price Prediction"),
  
  sidebarPanel(width = 12,
    #selectInput(
                #list("Fitbit Alta Bundle for Nathalia Lopez" = "var1",
                     #"iPad Gen 2 / Verizon" = "var2",
                     #"(50)Pusheen Unicorn Thank you Labels" = "var3",
                     #"hatsune mk=iku keychain" = "var4",
                     #"Leap frog" = "var5"
                     #)
    textInput("variable", "Name of Product", placeholder = "Product")
    
    ,
   selectInput("cat", "Category:", width = 500,
                choices = c("women", "men", "Kids", "Sports", "Electronics","Beauty","Vintage","Home","Other")
               
                ),
  
   conditionalPanel(
     condition = "input.cat == 'women'",
     selectInput("womensub","SubCategory:", width = 500,
                 choices = c("Makeup","Tops & Blouses","Jewelry","Swimwear","Athletic Apparl","Jeans","Garment","Handbags","Coats","Sweaters","Shoes")
     )),
   conditionalPanel(condition = "input.cat == 'men'",
                    selectInput("mensub","SubCategory:", width = 500,
                                choices = c("Shirt","Pants","T-shirt","Shoes","Athletic Apparel","Coats & Jackets","Men's Accessories","Sweaters","Garments","Sweats & Hoodies")
                    )),
                                
   conditionalPanel(condition = "input.cat == 'Kids'",
                    selectInput("Kidsub", "SubCategory:",width = 500,
                                choices = c("Backpacks","Toys","Arts & Crafts","Shoes","Doll & Accessories","Boys Accessories")
                               
                    )),
   conditionalPanel(condition = "input.cat == 'Sports'",
                    selectInput("Sportsub", "SubCategory:", width = 500,
                                choices = c("Fitness Technology","Fan Shop","Baseball & Softball","Outdoors Fishing","Apparel Girls","Footwear","Football","Apparel Boys"))),
  conditionalPanel(condition = "input.cat == 'Electronics'",
                   selectInput("Elecsub","SubCategory:", width = 500,
                               choices = c("Cell Phones & Accessories","Video Games & Consoles","Media","Computers & Tablets","TV, Audio & Surveillance","Cameras & Photography"))),
                              
  conditionalPanel(condition = "input.cat == 'Beauty'",
                   selectInput("Beautysub","SubCategory:", width = 500,
                               choices = c("Makeup","Women Fragrance","Tools & Accessories","Skin Care","Hair Care","Bath & Body"))),
                              
  selectInput("Brand", "Brand:",width = 500,
              choices = c("Fitbit","Apple","Homemade","Leap Frog","Razer","Target","Nike","Victoria's Secret","Wet n Wild","Samsung","Air Jordan","FOREVER 21","Xbox","PINK","Michael Kors","Kylie Cosmetics","Under Armour","Brandy Melville","Sephora")
  ),
  selectInput("Shipping", "Shipping:",width = 200,
              list("Free" = "1",
                   "Not Free" = "0")
  ),
  textInput("desc", "Description of product", placeholder = "Description"),
  actionButton(inputId = "action", label = "Make Prediction")
  ),
  #textInput("desc", "Description of product", placeholder = "Description", width = 1000),
  mainPanel(
    h1("$",textOutput("Prediction"))
  )
  
  
  
))
