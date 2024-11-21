//
//  Current.swift
//  WeatherAPIKit
//
//  Created by Dan Sinclair on 21/11/2024.
//

import Foundation

/// A response containing current weather conditions for a specific location.
///
/// This model represents the top-level response from the WeatherAPI.com current weather endpoint,
/// containing both location information and current weather data.
///
/// Example usage:
/// ```swift
/// let weather = try await client.current("London", apiKey: "key")
/// print("Temperature: \(weather.current.tempC)°C")
/// print("Location: \(weather.location.name), \(weather.location.country)")
/// ```
public struct CurrentWeather: Codable, Equatable {
    public let location: Location
    public let current: Current
    
    public init(location: Location, current: Current) {
        self.location = location
        self.current = current
    }
}

/// Geographical and timezone information for a weather location.
///
/// This model contains detailed information about a location, including its coordinates,
/// timezone, and regional information.
///
/// - Note: The `localtime` field is in the location's local timezone as specified by `tzId`.
public struct Location: Codable, Equatable {
    /// Name of the location (e.g., "London")
    public let name: String
    /// Region or state of the location (e.g., "City of London")
    public let region: String
    /// Country of the location (e.g., "United Kingdom")
    public let country: String
    /// Latitude in decimal degrees
    public let lat: Double
    /// Longitude in decimal degrees
    public let lon: Double
    /// Time zone identifier (e.g., "Europe/London")
    public let tzId: String
    /// Local time epoch in seconds since Unix epoch
    public let localtimeEpoch: Int
    /// Local time in format "yyyy-MM-dd HH:mm"
    public let localtime: String
    
    public init(
        name: String,
        region: String,
        country: String,
        lat: Double,
        lon: Double,
        tzId: String,
        localtimeEpoch: Int,
        localtime: String
    ) {
        self.name = name
        self.region = region
        self.country = country
        self.lat = lat
        self.lon = lon
        self.tzId = tzId
        self.localtimeEpoch = localtimeEpoch
        self.localtime = localtime
    }
    
    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzId = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}

/// Current weather conditions for a location.
///
/// This model contains comprehensive weather data including temperature, wind conditions,
/// humidity, visibility, and more. All measurements are provided in both metric and imperial units.
///
/// - Note: The `isDay` property is 1 if it's day time and 0 if it's night time at the location.
public struct Current: Codable, Equatable {
    /// Time of last update as epoch in seconds
    public let lastUpdatedEpoch: Int
    /// Time of last update as string
    public let lastUpdated: String
    /// Temperature in Celsius
    public let tempC: Double
    /// Temperature in Fahrenheit
    public let tempF: Double
    /// Whether it's daytime at the location
    public let isDay: Bool
    /// Weather condition details
    public let condition: Condition
    /// Wind speed in miles per hour
    public let windMph: Double
    /// Wind speed in kilometers per hour
    public let windKph: Double
    /// Wind direction in degrees
    public let windDegree: Int
    /// Wind direction as 16-point compass (e.g., "NSW")
    public let windDir: String
    /// Pressure in millibars
    public let pressureMb: Double
    /// Pressure in inches
    public let pressureIn: Double
    /// Precipitation amount in millimeters
    public let precipMm: Double
    /// Precipitation amount in inches
    public let precipIn: Double
    /// Humidity as percentage
    public let humidity: Int
    /// Cloud cover as percentage
    public let cloud: Int
    /// Feels like temperature in Celsius
    public let feelslikeC: Double
    /// Feels like temperature in Fahrenheit
    public let feelslikeF: Double
    /// Visibility in kilometers
    public let visKm: Double
    /// Visibility in miles
    public let visMiles: Double
    /// UV Index
    public let uv: Double
    /// Wind gust in miles per hour
    public let gustMph: Double
    /// Wind gust in kilometers per hour
    public let gustKph: Double
    
    public init(
        lastUpdatedEpoch: Int,
        lastUpdated: String,
        tempC: Double,
        tempF: Double,
        isDay: Bool,
        condition: Condition,
        windMph: Double,
        windKph: Double,
        windDegree: Int,
        windDir: String,
        pressureMb: Double,
        pressureIn: Double,
        precipMm: Double,
        precipIn: Double,
        humidity: Int,
        cloud: Int,
        feelslikeC: Double,
        feelslikeF: Double,
        visKm: Double,
        visMiles: Double,
        uv: Double,
        gustMph: Double,
        gustKph: Double
    ) {
        self.lastUpdatedEpoch = lastUpdatedEpoch
        self.lastUpdated = lastUpdated
        self.tempC = tempC
        self.tempF = tempF
        self.isDay = isDay
        self.condition = condition
        self.windMph = windMph
        self.windKph = windKph
        self.windDegree = windDegree
        self.windDir = windDir
        self.pressureMb = pressureMb
        self.pressureIn = pressureIn
        self.precipMm = precipMm
        self.precipIn = precipIn
        self.humidity = humidity
        self.cloud = cloud
        self.feelslikeC = feelslikeC
        self.feelslikeF = feelslikeF
        self.visKm = visKm
        self.visMiles = visMiles
        self.uv = uv
        self.gustMph = gustMph
        self.gustKph = gustKph
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lastUpdatedEpoch = try container.decode(Int.self, forKey: .lastUpdatedEpoch)
        lastUpdated = try container.decode(String.self, forKey: .lastUpdated)
        tempC = try container.decode(Double.self, forKey: .tempC)
        tempF = try container.decode(Double.self, forKey: .tempF)
        isDay = try container.decode(Int.self, forKey: .isDay) == 1
        condition = try container.decode(Condition.self, forKey: .condition)
        windMph = try container.decode(Double.self, forKey: .windMph)
        windKph = try container.decode(Double.self, forKey: .windKph)
        windDegree = try container.decode(Int.self, forKey: .windDegree)
        windDir = try container.decode(String.self, forKey: .windDir)
        pressureMb = try container.decode(Double.self, forKey: .pressureMb)
        pressureIn = try container.decode(Double.self, forKey: .pressureIn)
        precipMm = try container.decode(Double.self, forKey: .precipMm)
        precipIn = try container.decode(Double.self, forKey: .precipIn)
        humidity = try container.decode(Int.self, forKey: .humidity)
        cloud = try container.decode(Int.self, forKey: .cloud)
        feelslikeC = try container.decode(Double.self, forKey: .feelslikeC)
        feelslikeF = try container.decode(Double.self, forKey: .feelslikeF)
        visKm = try container.decode(Double.self, forKey: .visKm)
        visMiles = try container.decode(Double.self, forKey: .visMiles)
        uv = try container.decode(Double.self, forKey: .uv)
        gustMph = try container.decode(Double.self, forKey: .gustMph)
        gustKph = try container.decode(Double.self, forKey: .gustKph)
    }
    
    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMb = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case visKm = "vis_km"
        case visMiles = "vis_miles"
        case uv
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
    }
}

/// Weather condition information.
///
/// This model contains a text description and icon code for the current weather condition.
public struct Condition: Codable, Equatable {
    /// Text description of the condition (e.g., "Partly cloudy")
    public let text: String
    /// URL of weather icon
    public let icon: String
    /// Weather condition unique code
    public let code: Int
    
    public init(text: String, icon: String, code: Int) {
        self.text = text
        self.icon = icon
        self.code = code
    }
}
