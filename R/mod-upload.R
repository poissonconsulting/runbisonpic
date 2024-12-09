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

mod_upload_ui <- function(id, label = "upload") {
  ns <- NS(id)

  instructions <- bs4Dash::box(
    width = 12,
    title = shinyhelper::helper(
      div(HTML(glue::glue("Upload data &nbsp &nbsp &nbsp"))),
      content = "upload",
      size = "l"
    ),
    br(),
    tags$label("1. Download and fill in template"), br(),
    downloadButton(ns("download_template"), "Template"),
    br(), br(),
    tags$label("2. Upload data"),
    uiOutput(ns("upload_bison")),
    br(), br(), br(), br(),
    tags$label("Download example data set"), br(),
    downloadButton(ns("download_example"), "Example Data")
  )

  fluidRow(
    column(width = 3, instructions),
    column(width = 9, uiOutput(ns("ui_table")))
  )
}


mod_upload_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    rv <- reactiveValues(
      data = NULL,
      template_dl = NULL,
      reset = 1,
      state = NULL
    )

    # read in template
    path <- system.file(
      package = "bisonpictools",
      "template/template-bison.xlsx"
    )
    sheets <- readxl::excel_sheets(path)
    template_model <- lapply(sheets, function(x) readxl::read_excel(path, x))
    names(template_model) <- sheets

    # download template
    observe({
      template_dl <- lapply(template_model, function(x) {
        x$name <- NULL
        x <- x[0, ]
        x
      })

      rv$template_dl <- template_dl
    })


    output$download_template <- downloadHandler(
      filename = "template-bison-model.xlsx",
      content = function(file) {
        writexl::write_xlsx(rv$template_dl, file)
      }
    )

    # read in example data
    path2 <- system.file(
      package = "bisonpictools",
      "example-data/data-raw.xlsx"
    )
    sheets2 <- readxl::excel_sheets(path2)
    example_data <- lapply(sheets2, function(x) readxl::read_excel(path2, x))
    names(example_data) <- sheets2

    output$download_example <- downloadHandler(
      filename = "wood-bison-example-data.xlsx",
      content = function(file) {
        writexl::write_xlsx(example_data, file)
      }
    )

    # upload data widget
    output$upload_bison <- renderUI({
      rv$reset
      fileInput(
        ns("upload"),
        label = NULL,
        accept = c(".xlsx")
      )
    })

    # create template and data tabs
    output$ui_table <- renderUI({
      template_tabs <- lapply(sheets, function(i) {
        shiny::tabPanel(
          title = i,
          wellPanel(
            DT::DTOutput(ns(glue::glue("template_table_{i}"))),
            style = "font-size:80%",
            class = "wellpanel"
          )
        )
      })
      templates <- do.call(
        tabBox,
        c(
          template_tabs,
          id = ns("template_tabs"),
          width = 12,
          title = "Required data format"
        )
      )

      upload_tabs <- lapply(sheets, function(i) {
        shiny::tabPanel(
          title = i,
          wellPanel(
            DT::DTOutput(ns(glue::glue("upload_table_{i}"))),
            style = "font-size:85%",
            class = "wellpanel"
          )
        )
      })
      uploads <- do.call(
        tabBox,
        c(
          upload_tabs,
          id = ns("upload_tabs"),
          width = 12,
          title = "Uploaded data"
        )
      )
      tagList(templates, uploads)
    })

    # display template
    observe({
      template_mod <- lapply(template_model, chktemplate::template_human)
      lapply(sheets, function(x) {
        output[[glue::glue("template_table_{x}")]] <- DT::renderDT({
          template_table(template_mod[[x]])
        })
      })
    })

    # create and display uploaded data
    observeEvent(input$upload,
      {
        rv$data <- NULL

        sheets_data <- readxl::excel_sheets(input$upload$datapath)
        try_sheet_names <- try(
          check_sheet_names(sheets_data, sheets),
          silent = TRUE
        )
        if (is_try_error(try_sheet_names)) {
          return(showModal(check_modal(try_sheet_names, ns)))
        }
        data <- lapply(sheets_data, function(x) {
          readxl::read_excel(input$upload$datapath, sheet = x, na = c("", "NA"))
        })
        names(data) <- sheets_data

        # check types match
        data <- try(
          bisonpictools::bpt_check_data(
            location = data$location,
            event = data$event,
            census = data$census,
            proportion_calf = data$proportion_calf,
            complete = TRUE,
            join = TRUE,
            check_study_years = TRUE
          ),
          silent = TRUE
        )
        if (is_try_error(data)) {
          return(showModal(check_modal(data, ns)))
        }

        rv$data <- data
        rv$state <- "upload"
        rv$reset <- rv$reset + 1
      },
      label = "generating data"
    )

    observe({
      lapply(names(rv$data), function(x) {
        output[[glue::glue("upload_table_{x}")]] <- DT::renderDT({
          data_table(rv$data[[x]])
        })
      })
    })

    observeEvent(input$dismiss_modal, {
      rv$reset <- rv$reset + 1
      rv$data <- NULL
      rv$state <- NULL
      removeModal()
    })

    return(rv)
  })
}
