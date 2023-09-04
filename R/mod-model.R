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
    uiOutput(ns("ui_herd_size")),
    uiOutput(ns("ui_coef_variation")),
    actionButton(ns("run"), "Run")
  )

  output <- bs4Dash::box(
    width = 12,
    title = "Output",
    uiOutput(ns("ui_table"))
  )

  fluidRow(
    column(width = 3, instructions),
    column(width = 9, output)
  )
}


mod_model_server <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    rv <- reactiveValues(
      model_table = NULL
    )

    # control widgets
    output$ui_thinning <- renderUI({
      data$reset
      numericInput(
        ns("thinning"),
        label = "Model Thinning",
        value = 50,
        min = 1,
        max = 10000,
        step = 100
      )
    })

    output$ui_herd_size <- renderUI({
      data$reset
      numericInput(
        ns("herd_size"),
        label = "Initial Herd Size",
        value = 200,
        min = 1,
        max = 10000,
        step = 100
      )
    })

    output$ui_coef_variation <- renderUI({
      data$reset
      numericInput(
        ns("coef_variation"),
        label = "Coefficeint of Variation",
        value = 0.05,
        min = 0,
        max = 1,
        step = 0.05
      )
    })

    w <- waiter_model()

    observeEvent(input$run, {
      ## TO DO
      # checks if no data is present to not run model
      # confirm at end of app this is still valid with structure
      if (is.null(data$data)) {
        return(
          showModal(
            modalDialog(
              "No data has been uploaded, go to the Upload Data tab and upload your data.",
              title = "Please fix the following issue ...",
              footer = modalButton("Got it")
            )
          )
        )
      }

      w$show()
      # TO DO: switch out for model code
      Sys.sleep(5)
      mod <- stats::lm(f1 ~ f0, data = data$data$event)
      mod_sum <- summary(mod)
      rv$model_table <- data.frame(mod_sum$fstatistic)
      w$hide()
    })

    output$ui_table <- renderUI({
      DT::DTOutput(ns("table"))
    })

    output$table <- DT::renderDT({
      simple_table(rv$model_table)
    })
  })
}
