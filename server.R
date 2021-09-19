
function(input, output) {

    output$text1 <- renderUI(
        div(
            style = "text-align: justify, font-size:20px",
            HTML(
                "
                Logam merupakan komponen yang banyak digunakan dalam industri saat ini. Dibalik sifatnya yang kuat, logam juga dapat mengalami cacat baik karena proses produksi maupun karena usia penggunaannya.
                Deteksi cacat pada logam dapat saja dilakukan secara tradisional dengan mata telanjang. Namun, itu membutuhkan resource dan waktu yang lama. Oleh karena itu,
                penggunaan machine learning dapat membantu engineer mendeteksi cacat logam tanpa menghilangkan peran manusia sebagai pengambil keputusan akhir.
                "
            )
        )

    )

    output$output_image <- renderImage({
        req(input$input_image)

        outfile <- input$input_image$datapath
        contentType <- input$input_image$type
        list(src = outfile,
             contentType=contentType,
             width = 870,
             height = 144,
             align = "center")
    }, deleteFile = F)

    
    
    image <- reactive({image_load(input$input_image$datapath, target_size = target_size[1:2])})



    prediction <- reactive({

        if(is.null(input$input_image$datapath)){return(NULL)}
        x <- image_to_array(image())
        x <- array_reshape(x, c(1, dim(x)))
        x <- x/255
        pred <- as.data.frame(predict(model, x))
        
        pred_t <- pivot_longer(pred, cols = colnames(pred), # semua kolom di pivot longer
                                      names_to = "label", values_to = "value", )
        
        pred_raw <- pred_t %>% 
            arrange(desc(value)) %>% # urutkan
            head(1) %>% # pilih nilai pertama (max probability)
            pull(label) # ambil nilai label nya
        
        # fungsi decode
        decode <- function(x){
            case_when(x == "V1" ~ "1",
                      x == "V2" ~ "2",
                      x == "V3" ~ "3",
                      x == "V4" ~ "4"
            )
        }
        
        decode(pred_raw)
    })


    prediction2 <- reactive({

        if(is.null(input$input_image$datapath)){return(NULL)}

        x <- image_to_array(image())
        x <- array_reshape(x, c(1, dim(x)))
        x <- x/255
        pred2 <- predict(model, x)
        pred2 <- as.data.frame(pred2)
        # pred <- model %>% predict(x)
        # decode <- function(x){
        #     case_when(x == 0 ~ "1",
        #               x == 1 ~ "2",
        #               x == 2 ~ "3",
        #               x == 3 ~ "4"
        #     )
        # }
        # decode(pred2)
    })


    output$text <- renderText({
        prediction()
    })

    output$table <- renderTable({
        prediction2()
    })


    output$plot <- renderImage({
        list(src = "www/plot.png",
             width = "50%",
             height = "50%")
    }, deleteFile = F)

    output$defect1 <- renderImage({
        list(src = "www/1.jpg",
             width = "100%",
             height = "100%")
    }, deleteFile = F)

    output$defect2 <- renderImage({
        list(src = "www/2.jpg",
             width = "100%",
             height = "100%")
    }, deleteFile = F)

    output$defect3 <- renderImage({
        list(src = "www/3.jpg",
             width = "100%",
             height = "100%")
    }, deleteFile = F)

    output$defect4 <- renderImage({
        list(src = "www/4.jpg",
             width = "100%",
             height = "100%")
    }, deleteFile = F)
    
    
    output$algo <- renderImage({
        list(src = "www/Neural Network.png",
             width = "100%",
             height = "100%")
    }, deleteFile = F)
    
    
    output$gif <- renderImage({
        list(src = "www/animation.gif",
             width = "100%",
             height = "100%")
    }, deleteFile = F)
    
    output$dl <- renderImage({
        list(src = "www/nondeep.png",
             width = "100%",
             height = "100%")
    }, deleteFile = F)
    
    
    
}
