% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/functions.R
\name{get_forecast}
\alias{get_forecast}
\title{Retrieve 5-Day Weather Forecast}
\usage{
get_forecast(city, api_key, units = "metric")
}
\arguments{
\item{city}{Character string of the city name to get the forecast for.}

\item{api_key}{Character string of OpenWeatherMap API key.}

\item{units}{Character string specifying the units (default is "metric").}
}
\value{
List containing forecast data if successful, or NULL if there's an error.
}
\description{
Retrieve the 5-day weather forecast for a specified city
}
\examples{
\dontrun{get_forecast("Lausanne", "your_api_key")}
}
