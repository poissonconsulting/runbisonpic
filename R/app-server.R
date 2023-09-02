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

app_server <- function(input, output, session) {
  shinyhelper::observe_helpers(
    help_dir = system.file("helpfiles", package = "runbisonpic")
  )

  data <- mod_upload_server(
    "mod_upload_ui"
  )

  model <- mod_model_server(
    "mod_model_ui",
    data
  )

  mod_results_server(
    "mod_results_ui",
    data,
    model
  )

  mod_help_server(
    "mod_help_ui"
  )

  mod_about_server(
    "mod_about_ui"
  )
}
