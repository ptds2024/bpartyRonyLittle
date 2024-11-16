# bpartyRonyLittle

`bpartyRonyLittle` is an R package that combines weather forecasting tools and ice cream cone volume simulation. This package provides a range of functions for retrieving weather data, simulating cone geometry, and analyzing results interactively using a Shiny application. The package is designed for both educational and practical purposes, offering a user-friendly interface and robust functionalities.

---

## Features

- **Weather Data Retrieval**: Fetches real-time weather data and 5-day forecasts from the OpenWeatherMap API.
- **Cone Simulation Tools**: Simulates ice cream cone radius over time with visualization capabilities.
- **Interactive Shiny App**: Includes a Shiny application for interactive weather analysis and cone volume simulation.
- **User-Friendly Functions**: Well-documented functions for seamless integration into your analysis workflows.

---

## Installation

To install the package from GitHub, use the following commands:

```R
# Install the devtools package if not already installed
install.packages("devtools")

# Install bpartyRonyLittle from GitHub
devtools::install_github("ptds2024/bpartyRonyLittle")
```

## Getting Started

Load the package into your R session:

```R
library(bpartyRonyLittle)
```

### Example: Fetching Weather Data

Verify if a city is valid and retrieve its 5-day weather forecast:

```R
api_key <- "YOUR_API_KEY"  # Replace with your OpenWeatherMap API key

# Check if Lausanne is a valid city
is_valid <- check_city_validity("Lausanne", api_key = api_key)
if (is_valid) {
  forecast <- get_forecast("Lausanne", api_key = api_key)
  print(head(forecast))
}
```

### Example: Simulating Cone Geometry

Calculate and visualize the radius of an ice cream cone over time:

```R
# Calculate cone radius for a sequence of time points
radii <- cone_radius_for(1:10)

# Plot cone radius
plot(1:10, radii, type = "b", col = "blue", pch = 19,
     main = "Cone Radius Over Time",
     xlab = "Time", ylab = "Radius")
```

### Launch the Shiny App

Use the `run_app()` function to launch the interactive Shiny application:

```R
run_app(api_key = api_key)
```

## Documentation

Full documentation for the package, including all functions and examples, is available on the bpartyRonyLittle website.

## Requirements

- **R version**: ≥ 4.0.0
- **Dependencies**: The package imports the following libraries:
  - `httr`
  - `purrr`
  - `ggplot2`
  - `shiny`
  - `devtools`
- **API Key**: OpenWeatherMap API key required for fetching weather data.

## Contributing

Contributions are welcome! If you'd like to contribute to the development of `bpartyRonyLittle`, please follow these steps:

1. Fork the repository.
2. Create a new branch: `git checkout -b feature/your-feature`.
3. Commit your changes: `git commit -am 'Add some feature'`.
4. Push to the branch: `git push origin feature/your-feature`.
5. Open a pull request.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Acknowledgments

Special thanks to the PTDS 2024 organization for providing guidance and resources for this project.

## Contact

Developed by Ronald Medvedev.

For inquiries, please contact: Ronald.medvedev@unil.ch
