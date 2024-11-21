//
//  Forecast.swift
//  WeatherAPIKit
//
//  Created by Dan Sinclair on 21/11/2024.
//

import Foundation

/// A response containing both current weather and forecast data.
///
/// This model represents the top-level response from the WeatherAPI.com forecast endpoint,
/// containing location information, current conditions, and future forecast data.
///
/// Example usage:
/// ```swift
/// let forecast = try await client.forecast("London", days: 3, apiKey: "key")
/// for day in forecast.forecast.forecastday {
///     print("Date: \(day.date), Max: \(day.day.maxtempC)°C")
/// }
/// ```
public struct ForecastResponse: Codable, Equatable {
    public let location: Location
    public let current: Current
    public let forecast: Forecast
    
    public init(location: Location, current: Current, forecast: Forecast) {
        self.location = location
        self.current = current
        self.forecast = forecast
    }
}

/// Weather forecast data container.
///
/// This model contains an array of forecast days requested from the API.
public struct Forecast: Codable, Equatable {
    /// Array of daily forecasts
    public let forecastday: [ForecastDay]
    
    public init(forecastday: [ForecastDay]) {
        self.forecastday = forecastday
    }
}

/// Weather forecast for a specific day.
///
/// This model contains comprehensive forecast data for a single day, including
/// daily averages, astronomical data, and hour-by-hour forecasts.
public struct ForecastDay: Codable, Equatable {
    /// Date as "yyyy-MM-dd" string
    public let date: String
    /// Date as epoch (seconds since Unix epoch)
    public let dateEpoch: Int
    /// Day average/total weather data
    public let day: Day
    /// Astronomical data for the day
    public let astro: Astro
    /// Hour by hour weather data
    public let hour: [Hour]
    
    public init(
        date: String,
        dateEpoch: Int,
        day: Day,
        astro: Astro,
        hour: [Hour]
    ) {
        self.date = date
        self.dateEpoch = dateEpoch
        self.day = day
        self.astro = astro
        self.hour = hour
    }
    
    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, astro, hour
    }
}

/// Daily weather averages and totals.
///
/// This model contains aggregated weather data for a full day, including
/// maximum and minimum temperatures, averages, and total precipitation.
public struct Day: Codable, Equatable {
    /// Maximum temperature in Celsius
    public let maxtempC: Double
    /// Maximum temperature in Fahrenheit
    public let maxtempF: Double
    /// Minimum temperature in Celsius
    public let mintempC: Double
    /// Minimum temperature in Fahrenheit
    public let mintempF: Double
    /// Average temperature in Celsius
    public let avgtempC: Double
    /// Average temperature in Fahrenheit
    public let avgtempF: Double
    /// Maximum wind speed in miles per hour
    public let maxwindMph: Double
    /// Maximum wind speed in kilometers per hour
    public let maxwindKph: Double
    /// Total precipitation in millimeters
    public let totalprecipMm: Double
    /// Total precipitation in inches
    public let totalprecipIn: Double
    /// Total snow in centimeters
    public let totalsnowCm: Double
    /// Average visibility in kilometers
    public let avgvisKm: Double
    /// Average visibility in miles
    public let avgvisMiles: Double
    /// Average humidity as percentage
    public let avghumidity: Double
    /// Weather condition
    public let condition: Condition
    /// UV Index
    public let uv: Double
    
    public init(
        maxtempC: Double,
        maxtempF: Double,
        mintempC: Double,
        mintempF: Double,
        avgtempC: Double,
        avgtempF: Double,
        maxwindMph: Double,
        maxwindKph: Double,
        totalprecipMm: Double,
        totalprecipIn: Double,
        totalsnowCm: Double,
        avgvisKm: Double,
        avgvisMiles: Double,
        avghumidity: Double,
        condition: Condition,
        uv: Double
    ) {
        self.maxtempC = maxtempC
        self.maxtempF = maxtempF
        self.mintempC = mintempC
        self.mintempF = mintempF
        self.avgtempC = avgtempC
        self.avgtempF = avgtempF
        self.maxwindMph = maxwindMph
        self.maxwindKph = maxwindKph
        self.totalprecipMm = totalprecipMm
        self.totalprecipIn = totalprecipIn
        self.totalsnowCm = totalsnowCm
        self.avgvisKm = avgvisKm
        self.avgvisMiles = avgvisMiles
        self.avghumidity = avghumidity
        self.condition = condition
        self.uv = uv
    }
    
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case maxtempF = "maxtemp_f"
        case mintempC = "mintemp_c"
        case mintempF = "mintemp_f"
        case avgtempC = "avgtemp_c"
        case avgtempF = "avgtemp_f"
        case maxwindMph = "maxwind_mph"
        case maxwindKph = "maxwind_kph"
        case totalprecipMm = "totalprecip_mm"
        case totalprecipIn = "totalprecip_in"
        case totalsnowCm = "totalsnow_cm"
        case avgvisKm = "avgvis_km"
        case avgvisMiles = "avgvis_miles"
        case avghumidity
        case condition
        case uv
    }
}

/// Astronomical data for a specific day.
///
/// This model contains information about sun and moon times and phases.
public struct Astro: Codable, Equatable {
    /// Sunrise time in 12-hour format (e.g., "06:30 AM")
    public let sunrise: String
    /// Sunset time in 12-hour format (e.g., "07:19 PM")
    public let sunset: String
    /// Moonrise time in 12-hour format
    public let moonrise: String
    /// Moonset time in 12-hour format
    public let moonset: String
    /// Moon phase description (e.g., "Waxing Gibbous")
    public let moonPhase: String
    /// Moon illumination percentage
    public let moonIllumination: String
    
    public init(
        sunrise: String,
        sunset: String,
        moonrise: String,
        moonset: String,
        moonPhase: String,
        moonIllumination: String
    ) {
        self.sunrise = sunrise
        self.sunset = sunset
        self.moonrise = moonrise
        self.moonset = moonset
        self.moonPhase = moonPhase
        self.moonIllumination = moonIllumination
    }
    
    enum CodingKeys: String, CodingKey {
        case sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case moonIllumination = "moon_illumination"
    }
}

/// Weather conditions for a specific hour.
///
/// This model contains detailed weather data for a single hour, including
/// temperature, precipitation, wind conditions, and chances of weather events.
public struct Hour: Codable, Equatable {
    /// Time as epoch in seconds
    public let timeEpoch: Int
    /// Time as string in format "yyyy-MM-dd HH:mm"
    public let time: String
    /// Temperature in Celsius
    public let tempC: Double
    /// Temperature in Fahrenheit
    public let tempF: Double
    /// Whether it's daytime
    public let isDay: Bool
    /// Weather condition
    public let condition: Condition
    /// Wind speed in miles per hour
    public let windMph: Double
    /// Wind speed in kilometers per hour
    public let windKph: Double
    /// Wind direction in degrees
    public let windDegree: Int
    /// Wind direction as 16-point compass
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
    /// Wind chill temperature in Celsius
    public let windchillC: Double
    /// Wind chill temperature in Fahrenheit
    public let windchillF: Double
    /// Heat index in Celsius
    public let heatindexC: Double
    /// Heat index in Fahrenheit
    public let heatindexF: Double
    /// Dew point in Celsius
    public let dewpointC: Double
    /// Dew point in Fahrenheit
    public let dewpointF: Double
    /// Will it rain
    public let willItRain: Bool
    /// Chance of rain as percentage
    public let chanceOfRain: Int
    /// Will it snow
    public let willItSnow: Bool
    /// Chance of snow as percentage
    public let chanceOfSnow: Int
    /// Visibility in kilometers
    public let visKm: Double
    /// Visibility in miles
    public let visMiles: Double
    /// Wind gust in miles per hour
    public let gustMph: Double
    /// Wind gust in kilometers per hour
    public let gustKph: Double
    /// UV Index
    public let uv: Double
    
    public init(
        timeEpoch: Int,
        time: String,
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
        windchillC: Double,
        windchillF: Double,
        heatindexC: Double,
        heatindexF: Double,
        dewpointC: Double,
        dewpointF: Double,
        willItRain: Bool,
        chanceOfRain: Int,
        willItSnow: Bool,
        chanceOfSnow: Int,
        visKm: Double,
        visMiles: Double,
        gustMph: Double,
        gustKph: Double,
        uv: Double
    ) {
        self.timeEpoch = timeEpoch
        self.time = time
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
        self.windchillC = windchillC
        self.windchillF = windchillF
        self.heatindexC = heatindexC
        self.heatindexF = heatindexF
        self.dewpointC = dewpointC
        self.dewpointF = dewpointF
        self.willItRain = willItRain
        self.chanceOfRain = chanceOfRain
        self.willItSnow = willItSnow
        self.chanceOfSnow = chanceOfSnow
        self.visKm = visKm
        self.visMiles = visMiles
        self.gustMph = gustMph
        self.gustKph = gustKph
        self.uv = uv
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        timeEpoch = try container.decode(Int.self, forKey: .timeEpoch)
        time = try container.decode(String.self, forKey: .time)
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
        windchillC = try container.decode(Double.self, forKey: .windchillC)
        windchillF = try container.decode(Double.self, forKey: .windchillF)
        heatindexC = try container.decode(Double.self, forKey: .heatindexC)
        heatindexF = try container.decode(Double.self, forKey: .heatindexF)
        dewpointC = try container.decode(Double.self, forKey: .dewpointC)
        dewpointF = try container.decode(Double.self, forKey: .dewpointF)
        willItRain = try container.decode(Int.self, forKey: .willItRain) == 1
        chanceOfRain = try container.decode(Int.self, forKey: .chanceOfRain)
        willItSnow = try container.decode(Int.self, forKey: .willItSnow) == 1
        chanceOfSnow = try container.decode(Int.self, forKey: .chanceOfSnow)
        visKm = try container.decode(Double.self, forKey: .visKm)
        visMiles = try container.decode(Double.self, forKey: .visMiles)
        gustMph = try container.decode(Double.self, forKey: .gustMph)
        gustKph = try container.decode(Double.self, forKey: .gustKph)
        uv = try container.decode(Double.self, forKey: .uv)
    }
    
    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case time
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
        case windchillC = "windchill_c"
        case windchillF = "windchill_f"
        case heatindexC = "heatindex_c"
        case heatindexF = "heatindex_f"
        case dewpointC = "dewpoint_c"
        case dewpointF = "dewpoint_f"
        case willItRain = "will_it_rain"
        case chanceOfRain = "chance_of_rain"
        case willItSnow = "will_it_snow"
        case chanceOfSnow = "chance_of_snow"
        case visKm = "vis_km"
        case visMiles = "vis_miles"
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
        case uv
    }
}

