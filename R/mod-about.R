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

mod_about_ui <- function(id, label = "about") {
  ns <- NS(id)

  box(
    width = 12,
    collapsible = FALSE,
    uiOutput(ns("ui_about")),
    uiOutput(ns("ui_text_1"))
  )
}



mod_about_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    output$ui_about <- renderUI({
      includeMarkdown(
        system.file(package = "runbisonpic", "helpfiles/about.md")
      )
    })

    output$text_1 <- renderText({
      paste0(
        "bisonpictools version: ",
        as.character(utils::packageVersion("bisonpictools")),
        "<br/>",
        "runbisonpic version: ",
        as.character(utils::packageVersion("runbisonpic"))
      )
    })

    output$ui_text_1 <- renderUI({
      htmlOutput(ns("text_1"))
    })
  })
}
