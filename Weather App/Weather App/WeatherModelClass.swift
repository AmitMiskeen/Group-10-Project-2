//
//  WeatherModelClass.swift
//  Weather App
//
//  Created by Abhay Miskeen on 2023-08-03.
//

import Foundation
import MapKit

struct WeatherResponse: Decodable {
    let location: Location?
    let current: Weather?
    let forecast: Forecast?
    let error: Error?
}

struct Error: Decodable {
    let code: Int
    let message: String
}



struct Location: Decodable {
    let name: String
    let lat: Double
    let lon: Double
}

struct Weather: Decodable {
    let temp_c: Float
    let temp_f: Float
    let is_day: Int
    let condition: Conditions
}

struct Conditions: Decodable {
    let code: Int
    let text: String
    let icon: String
}

struct Forecast: Decodable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Decodable {
    let date: String
    let day: Day
}

struct Day: Decodable {
    let maxtemp_c: Float
    let maxtemp_f: Float
    let mintemp_c: Float
    let mintemp_f: Float
    let condition: Conditions
}

struct LocationItem {
    var locationName: String
    var temperature: String
    var weatherIconUrl: String
    var coordinate: CLLocationCoordinate2D
    var temperatureValue: Float
    let weatherData: WeatherResponse
}
