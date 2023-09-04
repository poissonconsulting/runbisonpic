# Copyright 2023 Province of Alberta

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

# http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

mod_results_ui <- function(id, label = "model") {
  ns <- NS(id)

  plots <- bs4Dash::box(
    title = "Plots",
    width = 12,
    tabsetPanel(
      tabPanel(
        title = "1. Plot",
        wellPanel(
          br(),
          uiOutput(ns("download_button_p1")),
          br(), br(),
          uiOutput(ns("ui_plot_1"))
        )
      ),
      tabPanel(
        title = "2. Plot",
        wellPanel(
          br(),
          uiOutput(ns("download_button_p2")),
          br(), br(),
          uiOutput(ns("ui_plot_2"))
        )
      ),
      tabPanel(
        title = "3. Plot",
        wellPanel(
          br(),
          uiOutput(ns("download_button_p3")),
          br(), br(),
          uiOutput(ns("ui_plot_3"))
        )
      )
    )
  )

  tables <- bs4Dash::box(
    width = 12,
    title = "Tables",
    tabsetPanel(
      tabPanel(
        title = "1. Table",
        wellPanel(
          br(),
          uiOutput(ns("download_button_t1")),
          br(), br(),
          uiOutput(ns("ui_table_1"))
        )
      ),
      tabPanel(
        title = "2. Table",
        wellPanel(
          br(),
          uiOutput(ns("download_button_t2")),
          br(), br(),
          uiOutput(ns("ui_table_2"))
        )
      ),
      tabPanel(
        title = "3. Table",
        wellPanel(
          br(),
          uiOutput(ns("download_button_t3")),
          br(), br(),
          uiOutput(ns("ui_table_3"))
        )
      )
    )
  )

  fluidPage(
    fluidRow(
      column(width = 12, plots, tables)
    )
  )
}


mod_results_server <- function(id, data, model) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    rv <- reactiveValues(
      plot_1 = NULL,
      plot_2 = NULL,
      plot_3 = NULL
    )

    ### TO DO
    # test data sets as place holder
    # will need to update if condition once model built in
    observe({
      if (!is.null(model$model_table)) {
        rv$data1 <- datasets::mtcars
        rv$data2 <- datasets::beaver2
        rv$data3 <- datasets::women
      }
    })

    # Plots
    output$plot_1 <- renderPlot({
      req(rv$data1)
      rv$plot_1 <- plot(rv$data1$mpg ~ rv$data1$disp)
      rv$plot_1
    })

    output$ui_plot_1 <- renderUI({
      plotOutput(ns("plot_1"))
    })

    output$download_button_p1 <- renderUI({
      req(rv$data1)
      downloadButton(ns("download_plot_1"), "Plot", class = "btn-plot")
    })

    output$download_plot_1 <- downloadHandler(
      filename = "runbisonpic_plot_1.png",
      content = function(file) {
        # plot <- rv$plot_1 +
        #   ggplot2::ggtitle("Plot 1 title")
        ggplot2::ggsave(
          file,
          rv$plot_1,
          device = "png"
        )
      }
    )

    output$plot_2 <- renderPlot({
      req(rv$data1)

      rv$plot_2 <- plot(rv$data1$drat ~ rv$data1$cyl)
      rv$plot_2
    })

    output$ui_plot_2 <- renderUI({
      plotOutput(ns("plot_2"))
    })

    output$download_button_p2 <- renderUI({
      req(rv$data1)
      downloadButton(ns("download_plot_2"), "Plot", class = "btn-plot")
    })

    output$download_plot_2 <- downloadHandler(
      filename = "runbisonpic_plot_2.png",
      content = function(file) {
        # plot <- rv$plot_2 +
        #   ggplot2::ggtitle("Plot 2 title")
        ggplot2::ggsave(
          file,
          rv$plot_2,
          device = "png"
        )
      }
    )

    output$plot_3 <- renderPlot({
      req(rv$data1)
      rv$plot_3 <- plot(rv$data1$gear ~ rv$data1$hp)
      rv$plot_3
    })

    output$ui_plot_3 <- renderUI({
      plotOutput(ns("plot_3"))
    })

    output$download_button_p3 <- renderUI({
      req(rv$data1)
      downloadButton(ns("download_plot_3"), "Plot", class = "btn-plot")
    })

    output$download_plot_3 <- downloadHandler(
      filename = "runbisonpic_plot_3.png",
      content = function(file) {
        # plot <- rv$plot_3 +
        #   ggplot2::ggtitle("Plot 3 title")
        ggplot2::ggsave(
          file,
          rv$plot_3,
          device = "png"
        )
      }
    )

    # Tables

    output$table_1 <- DT::renderDT(data_table(rv$data1))

    output$ui_table_1 <- renderUI({
      DT::DTOutput(ns("table_1"))
    })

    output$download_button_t1 <- renderUI({
      req(rv$data1)
      downloadButton(ns("download_table_1"), "Table", class = "btn-tbl")
    })

    output$download_table_1 <- downloadHandler(
      filename = "runbisonpic_table_1.csv",
      content = function(file) {
        utils::write.csv(rv$data1, file)
      }
    )

    output$table_2 <- DT::renderDT(data_table(rv$data2))

    output$ui_table_2 <- renderUI({
      DT::DTOutput(ns("table_2"))
    })

    output$download_button_t2 <- renderUI({
      req(rv$data2)
      downloadButton(ns("download_table_2"), "Table", class = "btn-tbl")
    })

    output$download_table_2 <- downloadHandler(
      filename = "runbisonpic_table_2.csv",
      content = function(file) {
        utils::write.csv(rv$data2, file)
      }
    )

    output$table_3 <- DT::renderDT(data_table(rv$data3))

    output$ui_table_3 <- renderUI({
      DT::DTOutput(ns("table_3"))
    })

    output$download_button_t3 <- renderUI({
      req(rv$data3)
      downloadButton(ns("download_table_3"), "Table", class = "btn-tbl")
    })

    output$download_table_3 <- downloadHandler(
      filename = "runbisonpic_table_3.csv",
      content = function(file) {
        utils::write.csv(rv$data3, file)
      }
    )

    observe({
      if (is.null(model$model_table)) {
        rv$data1 <- NULL
        rv$data2 <- NULL
        rv$data3 <- NULL
      }
    })

  })
}
