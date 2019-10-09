function(input,output){
  
  output$spThalach <- renderPlotly({
    heartt <- heart %>% 
      filter(sex == input$selectsex)
    bb <- ggplot(heartt, aes(x=age, y=thalach, colour=disease))+
      geom_line(size=1.5)+theme_linedraw()+theme(legend.title = element_blank())
    ggplotly(bb) })
  
  output$spChol <- renderPlotly({
    heartt <- heart %>% 
      filter(sex == input$selectsex)
    bb <- ggplot(heartt, aes(x=age, y=chol, colour=disease))+
      geom_line(size=1.5)+theme_linedraw()+theme(legend.title = element_blank())
    ggplotly(bb) %>% layout(legend=list(orientation="h",y=0,x=0)) })
  
  
  output$spOldpeak <- renderPlotly({
    heartt <- heart %>% 
      filter(sex == input$selectsex)
    bb <- ggplot(heartt, aes(x=age, y=oldpeak, colour=disease))+
      geom_line(size=1.5)+theme_linedraw()+theme(legend.title = element_blank())
    ggplotly(bb) })
  
  output$spTrestbps <- renderPlotly({
    heartt <- heart %>% 
      filter(sex == input$selectsex)
    bb <- ggplot(heartt, aes(x=age, y=trestbps, colour=disease))+
      geom_line(size=1.5)+theme_linedraw()+theme(legend.title = element_blank())
    ggplotly(bb) })
  
  ##PC##
  output$pcCP <- renderPlotly({
    ccc <- ggplot(heart) +
      geom_mosaic(aes(x = product(disease), fill = cp)) +
      facet_wrap(~sex)+xlab("Heart Disease")+ylab("Constrictive Pericarditis")+
      theme_calc()+
      guides(fill=guide_legend(title="\n \n Constrictive \n Pericarditis"))+
      theme(axis.text.y=element_blank(),
            legend.background = element_rect(fill="lightblue",
                                             size=0.5, linetype="solid", 
                                             colour ="darkblue"),
            legend.position='bottom', legend.title=element_text(colour = "blue", size=12))+
      theme(legend.title = element_blank())
    ggplotly(ccc)})
  
  output$pcExang <- renderPlotly({
    ccc <- ggplot(heart) +
      geom_mosaic(aes(x = product(disease), fill = exang)) +
      facet_wrap(~sex)+xlab("Heart Disease")+ylab("Exang")+
      theme_pander()+
      theme(axis.text.y=element_blank())+theme(legend.title = element_blank())
    ggplotly(ccc)})
  
  output$pcRestecg<- renderPlotly({
    ccc <- ggplot(heart) +
      geom_mosaic(aes(x = product(disease), fill = restecg)) +
      facet_wrap(~sex)+xlab("Heart Disease")+ylab("Restecg")+
      theme_pander()+
      theme(axis.text.y=element_blank())+guides(fill=guide_legend(title="Restecg"))
    +theme(legend.title = element_blank())
    ggplotly(ccc)})
  
  output$pcFBS<- renderPlotly({
    ccc <- ggplot(heart) +
      geom_mosaic(aes(x = product(disease), fill = fbs)) +
      facet_wrap(~sex)+xlab("Heart Disease")+ylab("Fasting Blood Sugar")+
      theme_pander()+
      theme(axis.text.y=element_blank())+guides(fill=guide_legend(title="Fasting Blood Sugar"))+theme(legend.title = element_blank())
    ggplotly(ccc)})
  
  output$pcSlope<- renderPlotly({
    ccc <- ggplot(heart) +
      geom_mosaic(aes(x = product(disease), fill = slope)) +
      facet_wrap(~sex)+xlab("Heart Disease")+ylab("Slope")+
      theme_pander()+
      theme(axis.text.y=element_blank())+guides(fill=guide_legend(title="Slope"))
    ggplotly(ccc)})
  
  output$pcThal<- renderPlotly({
    ccc <- ggplot(heart) +
      geom_mosaic(aes(x = product(disease), fill = thal)) +
      facet_wrap(~sex)+xlab("Heart Disease")+ylab("Thalassemia")+
      theme_pander()+
      
      theme(axis.text.y=element_blank())+guides(fill=guide_legend(title="Thalassemia"))
    ggplotly(ccc)})
  
  output$b_acc <- renderInfoBox({
    infoBox(title = "Accuracy of Naive Bayes Model", 
            value =  round(cm_bayes[[3]][1],2) ,
            icon = icon("columns"),
            color = "fuchsia", fill = TRUE, width = 4
    ) 
  })
  
  output$b_rec <- renderInfoBox({
    infoBox(title = "Recall of Naive Bayes Model", 
            value =  round(cm_bayes[[4]][1],2),
            icon = icon("columns"),
            color = "fuchsia", fill = TRUE, width = 4
    ) 
  })
  
  output$b_pre <- renderInfoBox({
    infoBox(title = "Precision of Naive Bayes Model", 
            value =  round(cm_bayes[[4]][3],2),
            icon = icon("columns"),
            color = "fuchsia", fill = TRUE, width = 4
    ) 
  })
  
  output$b_spe <- renderInfoBox({
    infoBox(title = "Specificity of Naive Bayes Model", 
            value =  round(cm_bayes[[4]][2],2),
            icon = icon("columns"),
            color = "fuchsia", fill = TRUE, width = 4
    ) 
  })
  
  
  
  ##tree
  output$t_acc <- renderInfoBox({
    infoBox(title = "Accuracy of Decision Tree Model", 
            value =  round(cm_tree[[3]][1],2) ,
            icon = icon("columns"),
            color = "olive", fill = TRUE, width = 4
    ) 
  })
  
  output$t_rec <- renderInfoBox({
    infoBox(title = "Recall of Decision Tree Model", 
            value =  round(cm_tree[[4]][1],2),
            icon = icon("columns"),
            color = "olive", fill = TRUE, width = 4
    ) 
  })
  
  output$t_pre <- renderInfoBox({
    infoBox(title = "Precision of Decision Tree Model", 
            value =  round(cm_tree[[4]][3],2),
            icon = icon("columns"),
            color = "olive", fill = TRUE, width = 4
    ) 
  })
  
  output$t_spe <- renderInfoBox({
    infoBox(title = "Specificity of Decision Tree Model", 
            value =  round(cm_tree[[4]][2],2),
            icon = icon("columns"),
            color = "olive", fill = TRUE, width = 4
    ) 
  })
 
  
  
  observeEvent(input$varpred,{
    output$b_pred <- renderValueBox({
      valueBox(predict(model_bayes, newdata = data.frame(age=input$umur,sex=input$sex,cp=input$cp, trestbps=input$trestbps,chol=input$chol, 
                                                         fbs=input$fbs, restecg=input$restecg, thalach=input$thalach, 
                                                         exang=input$exang, oldpeak=input$oldpeak, slope=input$slope, ca=input$ca, thal=
                                                           input$thal))
               
               , "Naive Bayes Prediction", icon = icon("thumbs-up", lib = "glyphicon"),
               color = "purple"
      )
    })
    
    output$t_pred <- renderValueBox({
      valueBox(predict(model_tree, newdata = data.frame(age=input$umur,sex=input$sex,cp=input$cp, trestbps=input$trestbps,chol=input$chol, 
                                                        fbs=input$fbs, restecg=input$restecg, thalach=input$thalach, 
                                                        exang=input$exang, oldpeak=input$oldpeak, slope=input$slope, ca=input$ca, thal=
                                                          input$thal))
               
               , "Decision Tree Prediction", icon = icon("thumbs-up", lib = "glyphicon"),
               color = "green"
      )
    })
    
    
  })
  
  

  
 ##tutup# 
}