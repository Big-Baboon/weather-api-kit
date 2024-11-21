//
//  WeatherError.swift
//  WeatherAPIKit
//
//  Created by Dan Sinclair on 21/11/2024.
//

import Foundation

/// Errors that can occur when using the WeatherClient.
public enum WeatherError: Error {
    /// The URL for the API request could not be constructed.
    case invalidURL
    
    /// The server returned an unexpected response or a non-200 status code.
    case invalidResponse
    
    /// The response data could not be decoded into the expected type.
    ///
    /// The associated value contains the underlying decoding error.
    case decodingError(Error)
}
