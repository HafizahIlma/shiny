
header <- dashboardHeader(title="Heart Disease Classification")
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(
      text="Visualization",
      tabName = "slide1",
      icon=icon("chart-bar")
    ),
    menuItem(
      text="Classifiers",
      tabName = "knn",
      icon=icon("share-alt")
    )
    
  )
)


body <- dashboardBody(fluidPage(
  tabItems(
    tabItem(
      
      
      tabName = "slide1",
      box(title =tags$b("Introduction"), width = 12, height = 150, status = "warning", solidHeader = TRUE,
          # textOutput(tags$div(

          tags$b(tags$h4("This is a dashboard that describes the data of sufferers of 'heart disease.'")),
          
          tags$b(tags$h4("This dashboard can also be considered by doctors in determining whether a person has heart disease or not.")),
          
          tags$b(tags$h4("The method used in classifying heart disease data is the Naive Bayes and Decision Tree model."))
          
          ),
      
      
      
      fluidRow(
        valueBox(width = 4,"14", 
                 "Variabels", 
                 icon = icon
                 ("columns"),
                 color = "light-blue"),
        valueBox(width = 4,"297",
                 "Observations",
                 icon = icon("list-ul"),
                 color = "fuchsia"),
        valueBox(width = 4,"117",
                 "Heart Disease (Yes)",
                 icon = icon("heartbeat"),
                 color = "olive")
      ),
      
      
      
      box(height = 545,
          tabBox(width = 12,height = 430,
                 title = tags$b("Line Chart"),
                 id = "tabset1",
                 side = "right",
                 tabPanel(tags$b("Thalach"), 
                          plotlyOutput("spThalach")),
                 tabPanel(tags$b("Trestbps"), 
                          plotlyOutput("spTrestbps")),
                 tabPanel(tags$b("Chol"), 
                          plotlyOutput("spChol")),
                 tabPanel(tags$b("Oldpeak"), 
                          plotlyOutput("spOldpeak"))
          ),
          fluidRow(
            column(
              width=4,
              selectInput(
                inputId="selectsex",
                label = "Select Gender:",
                choices = selectSex
                
              )
            ))),
    
      
      
    box(height = 545
        ,
        tabBox(width = 12,height = 430,
               title = tags$b("Bar Chart"),
               id = "tabset2",
               side = "left",
               tabPanel(tags$b("Constrictive Pericarditis"), 
                        plotlyOutput("pcCP")),
               
               
               tabPanel(tags$b("Fasting Blood Sugar"), 
                        plotlyOutput("pcFBS")),
               
               tabPanel(tags$b("Restecg"), 
                        plotlyOutput("pcRestecg")),
               
               tabPanel(tags$b("Exang"), 
                        plotlyOutput("pcExang")),
               
               tabPanel(tags$b("Slope"), 
                        plotlyOutput("pcSlope")),
               
               tabPanel(tags$b("Thalassemia"), 
                        plotlyOutput("pcThal"))
               
               
        ))
    
    
        
        ),
    
    
    #tab2
    
    tabItem(
      tabName = "knn",
      
      box(width=4, height = 1040,color="black",tabName="varpred",title = "Predictor Variabels",status = "warning", solidHeader = TRUE,
          fluidRow(box(width=6, numericInput(
            inputId="umur", 
            label="Age", 
            value=30,
            min=1, 
            max=100)),
            
            box(width = 6,selectInput(
              inputId="sex",
              label = "Sex:",
              choices = selectSex))),
          
          fluidRow(box(width = 6, selectInput(
            inputId="cp",
            label = "Chest Pain:",
            choices = selectCP)),
            
            box(width = 6, numericInput(
              inputId="trestbps",
              label="Resting Blood Pressure (mm Hg)",
              value=150,
              min=100,
              max=200))),
          
          
          fluidRow(box(width=6,numericInput(
            inputId="chol",
            label="Serum Cholestrol (mg/dl)",
            value=200,
            min=120,
            max=550)),
            
            box(width=6, selectInput(
              inputId="fbs",
              label = "Fasting Blood Sugar:",
              choices = selectFbs))),
          
          fluidRow(box(width=6, selectInput(
            inputId="restecg",
            label = "RestingEelectrocardiographic results:",
            choices = selectFbs)),
            
            box(width=6,numericInput(
              inputId="thalach",
              label="Maximum Heart Rate Achieved",
              value=150,
              min=70,
              max=203))),
          
          fluidRow(box(width=6,selectInput(
            inputId="ca",
            label = "Mumber of Major Vessels (0-3) colored by flourosopy:",
            choices = selectCa)),
            
            box(width=6, selectInput(
              inputId="slope",
              label = "The Slope of The Peak Exercise ST Segment:",
              choices = selectSlope))),
          
          fluidRow(box(width=6,selectInput(
            inputId="exang",
            
            label = "Exercise Induced angina:",
            choices = selectExang)),
            
            box(width=6,selectInput(
              inputId="thal",
              label = "Thalassemia:",
              choices = selectThal))),
          
          fluidRow(box(width=12
                       ,height = 2, numericInput(
                         inputId="oldpeak",
                         label="ST Depression Induced by Exercise Relative to Rest",
                         value=200,
                         min=120,
                         max=550)
          ))),
      ###
      
      box(width=8,height = 470,title = "Information Box of Naive Bayes Model vs Decision Tree Model",status = "warning", solidHeader = TRUE,
          fluidPage(
            fluidRow(infoBoxOutput(width=6,"b_acc"),infoBoxOutput(width=6,"t_acc")),
            fluidRow(infoBoxOutput(width=6,"b_rec"),infoBoxOutput(width=6,"t_rec")),
            fluidRow(infoBoxOutput(width=6,"b_pre"),infoBoxOutput(width=6,"t_pre")),
            fluidRow(infoBoxOutput(width=6,"b_spe"),infoBoxOutput(width=6,"t_spe"))
          )),
      box(width=8, height = 180,title = "Prediction BoxPrediction Results Suffer from Heart Disease or Not", status = "warning", solidHeader = TRUE,
          actionButton(inputId="varpred", label="Predict!",color="red", style='padding:6px;middle; font-size:175%'),
          valueBoxOutput(width = 5, "b_pred"),
          valueBoxOutput(width = 5,"t_pred")
      ),
      box(width = 4, height = 350, title=tags$b("Data"), 
          tags$b(tags$h4("A short description of the features and response of the dataset are provided in the list below.")),

          tags$b("1. (age): Age of the patient"),br(),
          tags$b("2. (sex): Sex of the patient"),br(),
          tags$b("3. (cp):  chest pain type"),br(),
          "1=typical angina, 2=atypical angine, 3=non-anginal pain, 4=asymptomatic", br(),
          tags$b("4. (trestbps):  resting blood pressure"),br(),
          tags$b("5. (chol):  serum cholesterol"),br(),
          tags$b("6. (fbs): fasting blood sugar"),br(),
          tags$b("7. (restecg): resting electrocardiographic results"),br(),
          "0=normal, 1=having ST-T wave abnormality, 2=showing probable or definite left ventricular hypertrophy",br(),
          tags$b("8. (thalach): maximum heart rate achieved"),

          status = "warning", 
          solidHeader = TRUE),
      
      
      box(width = 4, height = 350, title=tags$b("Data"), 
          
         
          tags$b("9. (exang): exercise induced angina"),br(),
          "1: yes, 2:no",br(),
          tags$b("10. (oldpeak): ST depression induced by exercise relative to rest"),br(),
          tags$b("11. (slope): the slope of the peak exercise ST segment"),br(),
          "1: upsloping, 2: flat, 3: downsloping", br(),
          tags$b("12. (ca): number of major vessels colored by flourosopy"),br(),
          "encoded with integers 0-3 colored by flourosopy", br(),
          tags$b("13. (thal): No explanation provided by UCI data descriptions"),br(),
          "3 = normal", br(),
          "6 = fixed defect", br(),
          "7 = reversable defect",br(),
          tags$b("14. (num):  diagnosis of heart disease (angiographic disease status)"),br(),
          "Value 0: < 50% diameter narrowing",br(),
          "Value 1: > 50% diameter narrowing",
          
          status = "warning", solidHeader = TRUE)

    
      
      
      ))))


dashboardPage(
  header=header,
  body=body,
  sidebar=sidebar,
  skin="yellow"
)