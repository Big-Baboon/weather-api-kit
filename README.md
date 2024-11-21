# WeatherAPIKit

A Swift package providing type-safe access to [WeatherAPI.com](https://www.weatherapi.com) services.

## Features

- ✨ Clean, modern Swift API with async/await
- 🔒 Type-safe models for all API responses
- 📦 Built with Swift Dependencies for easy dependency injection and testing
- 📝 Comprehensive documentation
- ⚡️ Support for current weather and forecasts
- 🌡️ Both metric and imperial measurements
- 🧪 Test helpers included

## Installation

### Swift Package Manager

Add this to your `Package.swift`:

```swift
dependencies: [
    .package(url: "your-repo/WeatherAPIKit", from: "1.0.0")
]
```

Or in Xcode:
1. File > Add Packages...
2. Enter the repository URL
3. Click "Add Package"

## Usage

First, [sign up for a WeatherAPI.com account](https://www.weatherapi.com/signup.aspx) to get an API key.

### Basic Usage

```swift
import WeatherAPIKit
import Dependencies

// In your view or service
@Dependency(\.weatherClient) var weatherClient

// Get current weather
let weather = try await weatherClient.current("London", apiKey: "your-api-key")
print("Temperature: \(weather.current.tempC)°C")
print("Condition: \(weather.current.condition.text)")

// Get forecast
let forecast = try await weatherClient.forecast("London", days: 3, apiKey: "your-api-key")
for day in forecast.forecast.forecastday {
    print("Date: \(day.date)")
    print("Max temp: \(day.day.maxtempC)°C")
    print("Min temp: \(day.day.mintempC)°C")
}
```

### Location Queries

The location query parameter supports various formats:
- City/Town name (e.g., "London")
- Latitude/Longitude (e.g., "48.8567,2.3508")
- US zip code (e.g., "90201")
- UK postcode (e.g., "SW1")
- Canada postal code (e.g., "G2J")
- metar:<metar code> (e.g., "metar:EGLL")
- iata:<3 digit airport code> (e.g., "iata:DXB")
- auto:ip IP lookup (e.g., "auto:ip")
- IP address (e.g., "100.0.0.1")

### Testing

The package includes test helpers through the Dependencies framework:

```swift
func testWeatherFeature() async throws {
    await withDependencies {
        $0.weatherClient.current = { query, apiKey in
            // Return mock data
            CurrentWeather(
                location: .init(/* ... */),
                current: .init(/* ... */)
            )
        }
    } operation: {
        // Your test code
    }
}
```

## Available Data

### Current Weather
- Temperature (C/F)
- Feels like temperature
- Wind speed and direction
- Precipitation
- Humidity
- Cloud cover
- Visibility
- UV index
- Condition text and icon

### Forecast
- Daily forecasts (1-10 days)
- Max/min temperature
- Chance of rain/snow
- Sunrise/sunset times
- Moon phase
- Hourly forecasts including:
  - Temperature
  - Precipitation chance
  - Wind conditions
  - Humidity
  - UV index

## Error Handling

The client can throw these errors:
```swift
public enum WeatherError: Error {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
}
```

## Requirements

- iOS 13.0+ / macOS 10.15+
- Swift 5.5+
- Xcode 13.0+

## Dependencies

- [swift-dependencies](https://github.com/pointfreeco/swift-dependencies)

## License

This package is available under the MIT license. See the LICENSE file for more info.
