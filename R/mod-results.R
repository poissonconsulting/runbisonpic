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
    title = shinyhelper::helper(
      div(HTML(glue::glue("Plots &nbsp &nbsp &nbsp"))),
      content = "result-plot",
      size = "l"
    ),
    width = 12,
    tabsetPanel(
      tabPanel(
        title = "1. Abundance Class",
        br(),
        uiOutput(ns("download_button_p1")),
        br(), br(),
        uiOutput(ns("ui_plot_ac"))
      ),
      tabPanel(
        title = "2. Abundance Total",
        br(),
        uiOutput(ns("download_button_p2")),
        br(), br(),
        uiOutput(ns("ui_plot_at"))
      ),
      tabPanel(
        title = "3. Survival",
        br(),
        uiOutput(ns("download_button_p3")),
        br(), br(),
        uiOutput(ns("ui_plot_surv"))
      ),
      tabPanel(
        title = "4. Fecundity",
        br(),
        uiOutput(ns("download_button_p4")),
        br(), br(),
        uiOutput(ns("ui_plot_fec"))
      ),
      tabPanel(
        title = "5. Ratios",
        br(),
        uiOutput(ns("download_button_p5")),
        br(), br(),
        uiOutput(ns("ui_plot_rat"))
      )
    )
  )

  tables <- bs4Dash::box(
    width = 12,
    title = shinyhelper::helper(
      div(HTML(glue::glue("Tables &nbsp &nbsp &nbsp"))),
      content = "result-table",
      size = "l"
    ),
    tabsetPanel(
      tabPanel(
        title = "1. Abundance Class",
        br(),
        uiOutput(ns("download_button_ac")),
        br(), br(),
        uiOutput(ns("ui_table_ac"))
      ),
      tabPanel(
        title = "2. Abundance Total",
        br(),
        uiOutput(ns("download_button_at")),
        br(), br(),
        uiOutput(ns("ui_table_at"))
      ),
      tabPanel(
        title = "3. Survival",
        br(),
        uiOutput(ns("download_button_surv")),
        br(), br(),
        uiOutput(ns("ui_table_surv"))
      ),
      tabPanel(
        title = "4. Fecundity",
        br(),
        uiOutput(ns("download_button_fec")),
        br(), br(),
        uiOutput(ns("ui_table_fec"))
      ),
      tabPanel(
        title = "5. Ratios",
        br(),
        uiOutput(ns("download_button_rat")),
        br(), br(),
        uiOutput(ns("ui_table_rat"))
      )
    )
  )

  fluidPage(
    fluidRow(
      column(width = 12, plots, tables)
    )
  )
}


mod_results_server <- function(id, upload, model) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    rv <- reactiveValues(
      plot_ac = NULL,
      plot_at = NULL,
      plot_surv = NULL,
      plot_fec = NULL,
      plot_rat = NULL,
      table_ac = NULL,
      table_at = NULL,
      table_surv = NULL,
      table_fec = NULL,
      table_rat = NULL
    )

    # Plots
    output$plot_ac <- renderPlot({
      req(model$analysis)
      rv$plot_ac <- bisonpictools::bpt_plot_predictions(
        model$analysis,
        "abundance-class"
      )
      rv$plot_ac
    })

    output$ui_plot_ac <- renderUI({
      req(model$analysis)
      plotOutput(ns("plot_ac"))
    })

    output$download_button_p1 <- renderUI({
      req(rv$plot_ac)
      downloadButton(ns("download_plot_ac"), "Plot", class = "btn-plot")
    })

    output$download_plot_ac <- downloadHandler(
      filename = "runbisonpic_plot_abundance_class.png",
      content = function(file) {
        plot <- rv$plot_ac +
          ggplot2::ggtitle("Abundance Class")
        ggplot2::ggsave(
          file,
          plot,
          device = "png"
        )
      }
    )

    output$plot_at <- renderPlot({
      req(model$analysis)
      rv$plot_at <- bisonpictools::bpt_plot_predictions(
        model$analysis,
        "abundance-total"
      )
      rv$plot_at
    })

    output$ui_plot_at <- renderUI({
      req(model$analysis)
      plotOutput(ns("plot_at"))
    })

    output$download_button_p2 <- renderUI({
      req(rv$plot_at)
      downloadButton(ns("download_plot_at"), "Plot", class = "btn-plot")
    })

    output$download_plot_at <- downloadHandler(
      filename = "runbisonpic_plot_abundance_total.png",
      content = function(file) {
        plot <- rv$plot_at +
          ggplot2::ggtitle("Abundance Total")
        ggplot2::ggsave(
          file,
          plot,
          device = "png"
        )
      }
    )

    output$plot_surv <- renderPlot({
      req(model$analysis)
      rv$plot_surv <- bisonpictools::bpt_plot_predictions(
        model$analysis,
        "survival"
      )
      rv$plot_surv
    })

    output$ui_plot_surv <- renderUI({
      req(model$analysis)
      plotOutput(ns("plot_surv"))
    })

    output$download_button_p3 <- renderUI({
      req(rv$plot_surv)
      downloadButton(ns("download_plot_surv"), "Plot", class = "btn-plot")
    })

    output$download_plot_surv <- downloadHandler(
      filename = "runbisonpic_plot_survival.png",
      content = function(file) {
        plot <- rv$plot_surv +
          ggplot2::ggtitle("Survival")
        ggplot2::ggsave(
          file,
          plot,
          device = "png"
        )
      }
    )

    output$plot_fec <- renderPlot({
      req(model$analysis)
      rv$plot_fec <- bisonpictools::bpt_plot_predictions(
        model$analysis,
        "fecundity"
      )
      rv$plot_fec
    })

    output$ui_plot_fec <- renderUI({
      req(model$analysis)
      plotOutput(ns("plot_fec"))
    })

    output$download_button_p4 <- renderUI({
      req(rv$plot_fec)
      downloadButton(ns("download_plot_fec"), "Plot", class = "btn-plot")
    })

    output$download_plot_fec <- downloadHandler(
      filename = "runbisonpic_plot_fecundity.png",
      content = function(file) {
        plot <- rv$plot_fec +
          ggplot2::ggtitle("Fecundity")
        ggplot2::ggsave(
          file,
          plot,
          device = "png"
        )
      }
    )

    output$plot_rat <- renderPlot({
      req(model$analysis)
      rv$plot_rat <- bisonpictools::bpt_plot_predictions(
        model$analysis,
        "ratios"
      )
      rv$plot_rat
    })

    output$ui_plot_rat <- renderUI({
      req(model$analysis)
      plotOutput(ns("plot_rat"))
    })

    output$download_button_p5 <- renderUI({
      req(rv$plot_rat)
      downloadButton(ns("download_plot_rat"), "Plot", class = "btn-plot")
    })

    output$download_plot_rat <- downloadHandler(
      filename = "runbisonpic_plot_ratios.png",
      content = function(file) {
        plot <- rv$plot_rat +
          ggplot2::ggtitle("Ratios")
        ggplot2::ggsave(
          file,
          plot,
          device = "png"
        )
      }
    )

    # Tables

    output$table_ac <- DT::renderDT({
      req(model$analysis)
      rv$pred_ac <- bisonpictools::bpt_predict_abundance_class(model$analysis)
    })

    output$ui_table_ac <- renderUI({
      req(model$analysis)
      DT::DTOutput(ns("table_ac"))
    })

    output$download_button_ac <- renderUI({
      req(rv$pred_ac)
      downloadButton(ns("download_table_ac"), "Table", class = "btn-tbl")
    })

    output$download_table_ac <- downloadHandler(
      filename = "runbisonpic_table_abundance_class.csv",
      content = function(file) {
        utils::write.csv(rv$pred_ac, file)
      }
    )

    output$table_at <- DT::renderDT({
      req(model$analysis)
      rv$pred_at <- bisonpictools::bpt_predict_abundance_total(model$analysis)
    })

    output$ui_table_at <- renderUI({
      req(model$analysis)
      DT::DTOutput(ns("table_at"))
    })

    output$download_button_at <- renderUI({
      req(rv$pred_at)
      downloadButton(ns("download_table_at"), "Table", class = "btn-tbl")
    })

    output$download_table_at <- downloadHandler(
      filename = "runbisonpic_table_abundance_total.csv",
      content = function(file) {
        utils::write.csv(rv$pred_at, file)
      }
    )

    output$table_surv <- DT::renderDT({
      req(model$analysis)
      rv$pred_surv <- bisonpictools::bpt_predict_survival(model$analysis)
    })

    output$ui_table_surv <- renderUI({
      req(model$analysis)
      DT::DTOutput(ns("table_surv"))
    })

    output$download_button_surv <- renderUI({
      req(rv$pred_surv)
      downloadButton(ns("download_table_surv"), "Table", class = "btn-tbl")
    })

    output$download_table_surv <- downloadHandler(
      filename = "runbisonpic_table_survival.csv",
      content = function(file) {
        utils::write.csv(rv$pred_surv, file)
      }
    )

    output$table_fec <- DT::renderDT({
      req(model$analysis)
      rv$pred_fec <- bisonpictools::bpt_predict_fecundity(model$analysis)
    })

    output$ui_table_fec <- renderUI({
      req(model$analysis)
      DT::DTOutput(ns("table_fec"))
    })

    output$download_button_fec <- renderUI({
      req(rv$pred_fec)
      downloadButton(ns("download_table_fec"), "Table", class = "btn-tbl")
    })

    output$download_table_fec <- downloadHandler(
      filename = "runbisonpic_table_fecundity.csv",
      content = function(file) {
        utils::write.csv(rv$pred_fec, file)
      }
    )

    output$table_rat <- DT::renderDT({
      req(model$analysis)
      rv$pred_rat <- bisonpictools::bpt_predict_ratios(model$analysis)
    })

    output$ui_table_rat <- renderUI({
      req(model$analysis)
      DT::DTOutput(ns("table_rat"))
    })

    output$download_button_rat <- renderUI({
      req(rv$pred_rat)
      downloadButton(ns("download_table_rat"), "Table", class = "btn-tbl")
    })

    output$download_table_rat <- downloadHandler(
      filename = "runbisonpic_table_ratios.csv",
      content = function(file) {
        utils::write.csv(rv$pred_rat, file)
      }
    )

    # Reset objects
    observe({
      if (is.null(model$analysis)) {
        rv$pred_ac <- NULL
        rv$pred_at <- NULL
        rv$pred_surv <- NULL
        rv$pred_fec <- NULL
        rv$pred_rat <- NULL

        rv$plot_ac <- NULL
        rv$plot_at <- NULL
        rv$plot_surv <- NULL
        rv$plot_fec <- NULL
        rv$plot_rat <- NULL
      }
    })
  })
}
