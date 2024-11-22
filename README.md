
# runbisonpic

<!-- badges: start -->

[![R-CMD-check](https://github.com/poissonconsulting/runbisonpic/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/poissonconsulting/runbisonpic/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

`runbisonpic` is a Shiny app for modeling wood bison camera trap data.
The app facilitates data checking and analysis by providing a simple
interface. The data are analyzed using an Bayesian Integrated Population
Model, which combines a stage-structured population projection matrix
model with multiple sources of data into a unified framework, allowing
for estimates of age-sex class ratios, population vital rates, and
abundances, while maintaining the correct propagation of uncertainty.
See the [analytical
methods](https://poissonconsulting.github.io/bisonpictools/articles/bisonpic-methods.html)
vignette for more detail on the modeling approach.

## Usage

### How to Install the R Package

To install from
[GitHub](https://github.com/poissonconsulting/runbisonpic)

``` r
# install.packages("remotes")
remotes::install_github("poissonconsulting/runbisonpic")
```

### How to Launch the App with Code

Run the function `launch_runbisonpic()` and the app will open in your
default web browser.

``` r
library(runbisonpic)
launch_runbisonpic()
```

### How to Launch the App with RStudio Addins Button

Click on the Addins drop-down and select **Start runbisonpic** App.

### User Guide

See the [user
guide](https://poissonconsulting.github.io/bisonpicsuite/articles/bisonpic-user-guide.html)
for step-by-step instructions on how to use the app.

Additional information is available from the
[`bisonpicsuite`](https://poissonconsulting.github.io/bisonpicsuite/)
and
[`bisonpictools`](https://poissonconsulting.github.io/bisonpictools/)
websites.

## bisonpic Suite

`runbisonpic` is part of the [bisonpic
suite](https://github.com/poissonconsulting/bisonpicsuite) of tools.
Other packages in this suite include:

- [bisonpictools](https://github.com/poissonconsulting/bisonpictools)
- [shinybisonpic](https://github.com/poissonconsulting/shinybisonpic)

## Contribution

Please report any
[issues](https://github.com/poissonconsulting/runbisonpic/issues).

## Code of Conduct

Please note that the runbisonpic project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
