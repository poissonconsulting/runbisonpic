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

# default colour for interactive objects: #0070C4
# light background colour: #F1F1F1

css_styling <- function() {
  x <- "
  .navbar-white {
    background-color: #F1F1F1;
  }

  a {
    color: #0070C4
  }

  .btn-plot {
    float: right;
    margin-right: 15px !important;
  }

  .btn-tbl {
    float: right;
    margin-right: 15px !important;
  }

  "
  tags$style(x, type = "text/css")
}
