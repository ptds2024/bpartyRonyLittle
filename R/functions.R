#' Calculate cone radius based on input x
#'
#' @title Calculate Cone Radius
#' @author Ronald Medvedev
#' @param x Numeric value indicating the position along the cone's height.
#' @return Numeric value representing the radius of the cone at position x.
#' @export
#' @examples
#' cone_radius(5)
#' cone_radius(9)
#' cone_radius(11)
cone_radius <- function(x) {
  if (!is.numeric(x)) stop("The x argument must be numeric.")

  if (x < 0) {
    return(0)
  } else if (x >= 0 && x < 8) {
    return(x / 8)
  } else if (x >= 8 && x < (8 + pi / 2)) {
    return(1 + 1.5 * sin(x - 8))
  } else if (x >= (8 + pi / 2) && x < 10) {
    return(2.5 - 2 * cos(x - 8))
  } else {
    return(0)
  }
}

#' Vectorized function for cone_radius using for loop
#'
#' @title Vectorized Cone Radius with For Loop
#' @author Ronald Medvedev
#' @param x Numeric vector.
#' @return Numeric vector with calculated radii for each x.
#' @export
#' @examples
#' cone_radius_for(c(0, 5, -1))
cone_radius_for <- function(x) {
  if (!is.numeric(x)) stop("The x argument must be numeric.")

  result <- numeric(length(x))
  for (i in seq_along(x)) {
    result[i] <- cone_radius(x[i])
  }
  return(result)
}

#' Vectorized function for cone_radius using map_dbl from purrr
#'
#' @title Vectorized Cone Radius with purrr::map_dbl
#' @author Ronald Medvedev
#' @param x Numeric vector.
#' @return Numeric vector with calculated radii for each x.
#' @export
#' @importFrom purrr map_dbl
#' @examples
#' cone_radius_map(c(0, 5, -1))
cone_radius_map <- function(x) {
  if (!is.numeric(x)) stop("The x argument must be numeric.")

  purrr::map_dbl(x, cone_radius)
}

#' Vectorized function for cone_radius using sapply
#'
#' @title Vectorized Cone Radius with sapply
#' @author Ronald Medvedev
#' @param x Numeric vector.
#' @return Numeric vector with calculated radii for each x.
#' @export
#' @examples
#' cone_radius_sapply(c(0, 5, -1))
cone_radius_sapply <- function(x) {
  if (!is.numeric(x)) stop("The x argument must be numeric.")

  sapply(x, cone_radius)
}

#' Vectorized function for cone_radius using Vectorize
#'
#' @title Vectorized Cone Radius using Vectorize
#' @author Ronald Medvedev
#' @param x Numeric vector.
#' @return Numeric vector with calculated radii for each x.
#' @export
#' @examples
#' cone_radius_vectorize(c(0, 5, -1))
cone_radius_vectorize <- Vectorize(cone_radius)

#' Function to compute the square of the cone radius
#'
#' @title Square of Cone Radius
#' @author Ronald Medvedev
#' @param x Numeric vector.
#' @return Numeric vector of squared radii.
#' @export
#' @examples
#' cone_radius_squared(c(0, 5))
cone_radius_squared <- function(x) {
  if (!is.numeric(x)) stop("The x argument must be numeric.")

  cone_radius_for(x)^2
}

#' Function to compute the derivative of the cone radius
#'
#' @title Derivative of Cone Radius
#' @param x Numeric vector.
#' @return Numeric vector representing the derivative of cone radius.
#' @export
#' @examples
#' cone_radius_derivative(c(5, 0))
cone_radius_derivative <- function(x) {
  if (!is.numeric(x)) stop("The x argument must be numeric.")

  epsilon <- 0.0001
  (cone_radius_for(x + epsilon) - cone_radius_for(x)) / epsilon
}

#' Run Shiny app for weather and ice cream simulation
#'
#' @title Run Shiny App for Weather and Ice Cream Simulation
#' @param api_key Character string of OpenWeatherMap API key.
#' @export
#' @import shiny
#' @examples
#' \dontrun{run_app("your_api_key")}
run_app <- function(api_key) {
  ui <- shiny::fluidPage(
    shiny::titlePanel("Enhanced Weather Forecast and Ice Cream Estimation App"),
    shiny::tabsetPanel(
      shiny::tabPanel("City 1", city_module_ui("city1")),
      shiny::tabPanel("City 2", city_module_ui("city2")),
      shiny::tabPanel("City 3", city_module_ui("city3"))
    )
  )

  server <- function(input, output, session) {
    city_module_server("city1", api_key)
    city_module_server("city2", api_key)
    city_module_server("city3", api_key)
  }

  shiny::shinyApp(ui = ui, server = server)
}

#' Shiny Module UI for City Weather and Ice Cream Estimation
#'
#' @title UI Module for City Weather and Ice Cream Estimation
#' @description This UI module provides input fields and display areas for city weather and ice cream simulation.
#' @author Ronald Medvedev
#' @param id Module ID for Shiny namespace.
#' @return A Shiny UI module that includes input fields for city name, weather parameter selection, and plots.
#' @export
#' @importFrom shiny NS tagList textInput selectInput numericInput actionButton htmlOutput plotOutput
#' @examples
#' \dontrun{shiny::shinyApp(ui = city_module_ui("module_id"), server = function(input, output) {})}
city_module_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::textInput(ns("city"), "Enter City Name:", value = "Lausanne"),
    shiny::selectInput(ns("parameter"), "Select Parameter:",
                       choices = c("Temperature" = "temperature", "Humidity" = "humidity", "Pressure" = "pressure"),
                       selected = "temperature"),
    shiny::numericInput(ns("num_simulations"), "Number of Simulations:", value = 10000, min = 1),
    shiny::actionButton(ns("run_simulation"), "Run Simulation"),
    shiny::actionButton(ns("submit"), "Submit"),
    shiny::htmlOutput(ns("current_weather")),
    shiny::plotOutput(ns("forecast_plot")),
    shiny::htmlOutput(ns("simulation_results")),
    shiny::plotOutput(ns("volume_histogram")),
    shiny::plotOutput(ns("surface_area_histogram"))
  )
}

#' Shiny Module Server for City Weather and Ice Cream Estimation
#'
#' @title Server Module for City Weather and Ice Cream Estimation
#' @description This server module handles weather data retrieval and visualization based on user input.
#' @author Ronald Medvedev
#' @param id Module ID for Shiny namespace.
#' @param api_key OpenWeatherMap API key for fetching weather data.
#' @return Shiny server logic for managing city weather data display and simulations based on input.
#' @export
#' @importFrom shiny moduleServer eventReactive isolate renderText renderPlot req HTML
#' @importFrom ggplot2 ggplot aes geom_line labs theme_minimal
#' @examples
#' \dontrun{
#' shiny::shinyApp(
#'   ui = city_module_ui("module_id"),
#'   server = function(input, output, session) {
#'     city_module_server("module_id", api_key = "your_api_key")
#'   }
#' )
#' }
city_module_server <- function(id, api_key) {
  shiny::moduleServer(id, function(input, output, session) {
    weather_data <- shiny::eventReactive(input$submit, {
      shiny::isolate({
        city_name <- input$city
        if (!check_city_validity(city_name, api_key)) {
          stop("City not found in the dataset.")
        }
        forecast_data <- get_forecast(city = city_name, api_key = api_key)
        if (is.null(forecast_data) || is.null(forecast_data$list) || nrow(forecast_data$list) == 0) {
          stop("No forecast data available.")
        }
        dates <- as.POSIXct(forecast_data$list$dt, origin = "1970-01-01", tz = "UTC")
        temps <- forecast_data$list$main$temp
        humidities <- forecast_data$list$main$humidity
        pressures <- forecast_data$list$main$pressure
        data.frame(date = dates, temperature = temps, humidity = humidities, pressure = pressures)
      })
    })

    output$current_weather <- shiny::renderText({
      shiny::req(weather_data())
      city <- shiny::isolate(input$city)
      temperature <- format(weather_data()$temperature[1], digits = 2)
      humidity <- weather_data()$humidity[1]
      pressure <- weather_data()$pressure[1]
      shiny::HTML(paste(
        "<strong>Current weather in", city, ":</strong><br>",
        "<ul><li>Temperature: ", temperature, " &deg;C</li>",
        "<li>Humidity: ", humidity, "%</li>",
        "<li>Pressure: ", pressure, "hPa</li></ul>"
      ))
    })

    output$forecast_plot <- shiny::renderPlot({
      df <- weather_data()
      parameter <- shiny::isolate(input$parameter)
      ggplot2::ggplot(df, ggplot2::aes(x = date)) +
        ggplot2::geom_line(ggplot2::aes_string(y = parameter, color = shQuote(parameter))) +
        ggplot2::labs(title = paste("5-Day Forecast for", shiny::isolate(input$city)), x = "Date", y = parameter, color = "Parameter") +
        ggplot2::theme_minimal()
    })
  })
}

#' Check if a city name is valid by querying the OpenWeatherMap API
#'
#' @title Check City Validity via API
#' @param city_name Character string representing the name of the city to check.
#' @param api_key Character string of OpenWeatherMap API key.
#' @return Logical value indicating if the city is valid.
#' @export
#' @examples
#' \dontrun{check_city_validity("Lausanne", "your_api_key")}
check_city_validity <- function(city_name, api_key) {
  if (!is.character(city_name)) stop("The city_name argument must be a character string.")

  response <- httr::GET("http://api.openweathermap.org/data/2.5/weather",
                        query = list(q = city_name, appid = api_key))

  status <- httr::status_code(response)
  return(status == 200)
}

#' Retrieve the 5-day weather forecast for a specified city
#'
#' @title Retrieve 5-Day Weather Forecast
#' @param city Character string of the city name to get the forecast for.
#' @param api_key Character string of OpenWeatherMap API key.
#' @param units Character string specifying the units (default is "metric").
#' @return List containing forecast data if successful, or NULL if there's an error.
#' @export
#' @examples
#' \dontrun{get_forecast("Lausanne", "your_api_key")}
get_forecast <- function(city, api_key, units = "metric") {
  if (!is.character(city)) stop("The city argument must be a character string.")

  response <- httr::GET("http://api.openweathermap.org/data/2.5/forecast",
                        query = list(q = city, appid = api_key, units = units))

  if (httr::status_code(response) != 200) {
    cat("Forecast request error:", httr::status_code(response), "\n")
    return(NULL)
  }

  httr::content(response, "parsed", simplifyDataFrame = TRUE)
}
