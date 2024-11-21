//
//  File.swift
//  WeatherAPIKit
//
//  Created by Dan Sinclair on 21/11/2024.
//

import Dependencies
import Foundation

/// A client for interacting with the WeatherAPI.com service.
///
/// This client provides methods to fetch current weather conditions and forecasts for locations
/// worldwide using the WeatherAPI.com REST API.
///
/// Example usage:
/// ```swift
/// @Dependency(\.weatherClient) var weatherClient
///
/// // Fetch current weather
/// let weather = try await weatherClient.current("London", apiKey: "your_api_key")
/// print("Temperature: \(weather.current.tempC)°C")
///
/// // Fetch forecast
/// let forecast = try await weatherClient.forecast("London", days: 3, apiKey: "your_api_key")
/// for day in forecast.forecast.forecastday {
///     print("Date: \(day.date), Max: \(day.day.maxtempC)°C")
/// }
/// ```
public struct WeatherClient: Sendable {
    
    /// Fetches current weather conditions for a specified location.
    ///
    /// - Parameters:
    ///   - query: The location query string. This can be:
    ///     - City/Town name (e.g., "London")
    ///     - Latitude/Longitude (e.g., "48.8567,2.3508")
    ///     - US zip code (e.g., "90201")
    ///     - UK postcode (e.g., "SW1")
    ///     - Canada postal code (e.g., "G2J")
    ///     - metar:<metar code> (e.g., "metar:EGLL")
    ///     - iata:<3 digit airport code> (e.g., "iata:DXB")
    ///     - auto:ip IP lookup (e.g., "auto:ip")
    ///     - IP address (e.g., "100.0.0.1")
    ///   - apiKey: Your WeatherAPI.com API key
    ///
    /// - Returns: A `CurrentWeather` object containing the current weather conditions.
    ///
    /// - Throws:
    ///   - `WeatherError.invalidURL`: If the URL cannot be constructed
    ///   - `WeatherError.invalidResponse`: If the server returns a non-200 status code
    ///   - `WeatherError.decodingError`: If the response cannot be decoded
    public var current: @Sendable (_ query: String, _ apiKey: String) async throws -> CurrentWeather
    
    /// Fetches weather forecast for a specified location.
    ///
    /// - Parameters:
    ///   - query: The location query string. Accepts the same format as the `current` method.
    ///   - days: Number of days of forecast required (1-10)
    ///   - apiKey: Your WeatherAPI.com API key
    ///
    /// - Returns: A `ForecastResponse` object containing the forecast data for the requested days.
    ///
    /// - Throws:
    ///   - `WeatherError.invalidURL`: If the URL cannot be constructed
    ///   - `WeatherError.invalidResponse`: If the server returns a non-200 status code
    ///   - `WeatherError.decodingError`: If the response cannot be decoded
    ///
    /// - Note: The forecast includes:
    ///   - Weather condition text and icon
    ///   - Max/min temperature in celsius and fahrenheit
    ///   - Chance of rain
    ///   - Chance of snow
    ///   - UV Index
    ///   - Hourly forecast information
    public var forecast: @Sendable (_ query: String, _ days: Int, _ apiKey: String) async throws -> ForecastResponse
}

extension WeatherClient: DependencyKey {
    
    /// The live implementation of `WeatherClient` that communicates with the WeatherAPI.com service.
    ///
    /// This implementation:
    /// - Makes real network requests to WeatherAPI.com
    /// - Handles JSON decoding of responses
    /// - Provides error handling for network and decoding issues
    public static let liveValue: WeatherClient = {
        let session = URLSession.shared
        
        @Sendable func makeRequest<T: Decodable>(
            apiKey: String,
            endpoint: String,
            queryItems: [URLQueryItem]
        ) async throws -> T {
            var components = URLComponents(
                url: URL(string: "https://api.weatherapi.com/v1/\(endpoint)")!,
                resolvingAgainstBaseURL: true
            )
            
            var items = queryItems
            items.append(URLQueryItem(name: "key", value: apiKey))
            components?.queryItems = items
            
            guard let url = components?.url else {
                throw WeatherError.invalidURL
            }
            
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw WeatherError.invalidResponse
            }
            
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw WeatherError.decodingError(error)
            }
        }
        
        return Self(
            current: { query, apiKey in
                try await makeRequest(
                    apiKey: apiKey,
                    endpoint: "current.json",
                    queryItems: [URLQueryItem(name: "q", value: query)]
                )
            },
            forecast: { query, days, apiKey in
                try await makeRequest(
                    apiKey: apiKey,
                    endpoint: "forecast.json",
                    queryItems: [
                        URLQueryItem(name: "q", value: query),
                        URLQueryItem(name: "days", value: String(days))
                    ]
                )
            }
        )
    }()
}

extension DependencyValues {
    
    /// Access to the weather client for making weather-related requests.
    ///
    /// Use this dependency in your code to fetch weather data:
    /// ```swift
    /// @Dependency(\.weatherClient) var weatherClient
    /// ```
    public var weatherClient: WeatherClient {
        get { self[WeatherClient.self] }
        set { self[WeatherClient.self] = newValue }
    }
}
