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

mod_model_ui <- function(id, label = "results") {
  ns <- NS(id)

  instructions <- bs4Dash::box(
    width = 12,
    title = shinyhelper::helper(
      div(HTML(glue::glue("Run Model &nbsp &nbsp &nbsp"))),
      content = "model",
      size = "l"
    ),
    uiOutput(ns("ui_thinning")),
    uiOutput(ns("ui_model_type")),
    actionButton(ns("run"), "Run")
  )

  output <- bs4Dash::box(
    width = 12,
    title = "Output",
    br(),
    uiOutput(ns("download_button_tbl")),
    uiOutput(ns("download_button_analysis")),
    br(), br(),
    uiOutput(ns("ui_table"))
  )

  fluidRow(
    column(width = 3, instructions),
    column(width = 9, output)
  )
}


mod_model_server <- function(id, upload) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    rv <- reactiveValues(
      model_table = NULL
    )

    # control widgets
    output$ui_thinning <- renderUI({
      upload$reset
      numericInput(
        ns("thinning"),
        label = "Thinning",
        value = 1,
        min = 1,
        max = 10000,
        step = 100
      )
    })

    output$ui_model_type <- renderUI({
      upload$reset
      selectInput(
        ns("model_type"),
        label = "Model Type",
        choices = c("report", "quick", "debug"),
        selected = "quick"
      )
    })

    w <- waiter_model()

    observeEvent(input$run, {
      if (is.null(upload$data)) {
        return(
          showModal(
            modalDialog(
              "No data has been uploaded, go to the Upload Data tab and upload
              data before running the model.",
              title = "Please fix the following issue ...",
              footer = modalButton("Got it")
            )
          )
        )
      }

      w$show()
      rv$analysis <- bisonpictools::bpt_analyse(
        event_data = upload$data$event,
        location_data = upload$data$location,
        census_data = upload$data$census,
        proportion_calf_data = upload$data$proportion_calf,
        nthin = input$thinning,
        analysis_mode = input$model_type
      )
      rv$model_table <- embr::glance(rv$analysis)
      rv$model_table$model_type <- input$model_type
      w$hide()
    })

    output$ui_table <- renderUI({
      DT::DTOutput(ns("table"))
    })

    output$table <- DT::renderDT({
      simple_table(rv$model_table)
    })

    # Download
    output$download_button_analysis <- renderUI({
      req(rv$analysis)
      downloadButton(
        ns("download_analysis"),
        "Analysis Object",
        class = "btn-tbl"
      )
    })

    output$download_analysis <- downloadHandler(
      filename = "runbisonpic_analysis.rds",
      content = function(file) {
        saveRDS(rv$analysis, file)
      }
    )

    output$download_button_tbl <- renderUI({
      req(rv$model_table)
      downloadButton(ns("download_table"), "Table", class = "btn-tbl")
    })

    output$download_table <- downloadHandler(
      filename = "runbisonpic_glance.csv",
      content = function(file) {
        utils::write.csv(rv$model_table, file)
      }
    )

    # clean up
    observe({
      if (is.null(upload$state)) {
        rv$analysis <- NULL
        rv$model_table <- NULL
      }
    })

    observeEvent(upload$reset, {
      rv$analysis <- NULL
      rv$model_table <- NULL
    })

    return(rv)
  })
}
