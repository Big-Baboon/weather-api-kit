//
//  WeatherClient+TestKey.swift
//  WeatherAPIKit
//
//  Created by Dan Sinclair on 21/11/2024.
//

import Dependencies
import XCTestDynamicOverlay

extension WeatherClient: TestDependencyKey {
    public static var testValue: WeatherClient {
        Self(
            current: unimplemented("\(Self.self).current", placeholder: CurrentWeather(
                location: .init(
                    name: "",
                    region: "",
                    country: "",
                    lat: 0,
                    lon: 0,
                    tzId: "",
                    localtimeEpoch: 0,
                    localtime: ""
                ),
                current: .init(
                    lastUpdatedEpoch: 0,
                    lastUpdated: "",
                    tempC: 0,
                    tempF: 0,
                    isDay: false,
                    condition: .init(text: "", icon: "", code: 0),
                    windMph: 0,
                    windKph: 0,
                    windDegree: 0,
                    windDir: "",
                    pressureMb: 0,
                    pressureIn: 0,
                    precipMm: 0,
                    precipIn: 0,
                    humidity: 0,
                    cloud: 0,
                    feelslikeC: 0,
                    feelslikeF: 0,
                    visKm: 0,
                    visMiles: 0,
                    uv: 0,
                    gustMph: 0,
                    gustKph: 0
                )
            )),
            forecast: unimplemented("\(Self.self).forecast", placeholder: ForecastResponse(
                location: .init(
                    name: "",
                    region: "",
                    country: "",
                    lat: 0,
                    lon: 0,
                    tzId: "",
                    localtimeEpoch: 0,
                    localtime: ""
                ),
                current: .init(
                    lastUpdatedEpoch: 0,
                    lastUpdated: "",
                    tempC: 0,
                    tempF: 0,
                    isDay: false,
                    condition: .init(text: "", icon: "", code: 0),
                    windMph: 0,
                    windKph: 0,
                    windDegree: 0,
                    windDir: "",
                    pressureMb: 0,
                    pressureIn: 0,
                    precipMm: 0,
                    precipIn: 0,
                    humidity: 0,
                    cloud: 0,
                    feelslikeC: 0,
                    feelslikeF: 0,
                    visKm: 0,
                    visMiles: 0,
                    uv: 0,
                    gustMph: 0,
                    gustKph: 0
                ),
                forecast: .init(forecastday: [])
            ))
        )
    }
    
    public static let previewValue = Self(
        current: { _, _ in
            CurrentWeather(
                location: .init(
                    name: "New York",
                    region: "New York",
                    country: "United States of America",
                    lat: 40.71,
                    lon: -74.01,
                    tzId: "America/New_York",
                    localtimeEpoch: 1636000000,
                    localtime: "2021-11-04 12:00"
                ),
                current: .init(
                    lastUpdatedEpoch: 1636000000,
                    lastUpdated: "2021-11-04 12:00",
                    tempC: 22,
                    tempF: 71.6,
                    isDay: true,
                    condition: .init(
                        text: "Sunny",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
                        code: 1000
                    ),
                    windMph: 5.6,
                    windKph: 9.0,
                    windDegree: 220,
                    windDir: "SW",
                    pressureMb: 1012.0,
                    pressureIn: 29.89,
                    precipMm: 0.0,
                    precipIn: 0.0,
                    humidity: 65,
                    cloud: 0,
                    feelslikeC: 24.5,
                    feelslikeF: 76.1,
                    visKm: 10.0,
                    visMiles: 6.2,
                    uv: 5.0,
                    gustMph: 6.7,
                    gustKph: 10.8
                )
            )
        },
        forecast: { _, _, _ in
            ForecastResponse(
                location: .init(
                    name: "New York",
                    region: "New York",
                    country: "United States of America",
                    lat: 40.71,
                    lon: -74.01,
                    tzId: "America/New_York",
                    localtimeEpoch: 1636000000,
                    localtime: "2021-11-04 12:00"
                ),
                current: .init(
                    lastUpdatedEpoch: 1636000000,
                    lastUpdated: "2021-11-04 12:00",
                    tempC: 22,
                    tempF: 71.6,
                    isDay: true,
                    condition: .init(
                        text: "Sunny",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
                        code: 1000
                    ),
                    windMph: 5.6,
                    windKph: 9.0,
                    windDegree: 220,
                    windDir: "SW",
                    pressureMb: 1012.0,
                    pressureIn: 29.89,
                    precipMm: 0.0,
                    precipIn: 0.0,
                    humidity: 65,
                    cloud: 0,
                    feelslikeC: 24.5,
                    feelslikeF: 76.1,
                    visKm: 10.0,
                    visMiles: 6.2,
                    uv: 5.0,
                    gustMph: 6.7,
                    gustKph: 10.8
                ),
                forecast: .init(forecastday: [])
            )
        }
    )
}
