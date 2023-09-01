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

mod_model_ui <- function(id, label = "model") {

  ns <- NS(id)

  instructions <- bs4Dash::box(
    width = 12
  )

  fluidRow(
    column(width = 4, instructions),
    column(width = 8, uiOutput(ns("ui_table")))
  )

}


mod_model_server <- function(id, upload) {
  moduleServer(id, function(input, output, session) {

    ns <- session$ns


  })
}
