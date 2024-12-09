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

app_ui <- function() {
  dashboardPage(
    dark = NULL,
    help = NULL,
    scrollToTop = TRUE,
    controlbar = NULL,
    footer = NULL,
    header = dashboardHeader(
      ... = div(
        h3("Wood Bison Camera-Based Demographic Model"),
        style = "vertical-align: baseline;"
      )
    ),
    sidebar = dashboardSidebar(
      skin = "light",
      sidebarMenu(
        id = "sidebarmenu",
        menuItem(
          "Upload Data",
          tabName = "upload",
          icon = icon("upload")
        ),
        menuItem(
          "Run Model",
          tabName = "model",
          icon = icon("diagram-project")
        ),
        menuItem(
          "Results",
          tabName = "results",
          icon = icon("chart-area")
        ),
        menuItem(
          "Help",
          tabName = "help",
          icon = icon("question")
        ),
        menuItem(
          "About",
          tabName = "about",
          icon = icon("info")
        )
      )
    ),
    body = dashboardBody(
      css_styling(),
      waiter::useWaiter(),
      tabItems(
        tabItem(
          tabName = "upload",
          mod_upload_ui("mod_upload_ui")
        ),
        tabItem(
          tabName = "model",
          mod_model_ui("mod_model_ui")
        ),
        tabItem(
          tabName = "results",
          mod_results_ui("mod_results_ui")
        ),
        tabItem(
          tabName = "help",
          mod_help_ui("mod_help_ui")
        ),
        tabItem(
          tabName = "about",
          mod_about_ui("mod_about_ui")
        )
      )
    ),
    freshTheme = fresh::create_theme(
      fresh::bs4dash_layout(main_bg = "#F1F1F1"),
      fresh::bs4dash_sidebar_light(
        bg = "#F1F1F1",
        submenu_bg = "#F1F1F1"
      ),
      fresh::bs4dash_status(
        primary = "#0070C4",
        light = "#FEBA35"
      )
    )
  )
}
