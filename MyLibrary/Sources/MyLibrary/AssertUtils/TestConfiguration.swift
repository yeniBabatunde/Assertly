//
//  TestConfiguration.swift
//  Assertly
//
//  Created by Sharon Omoyeni Babatunde on 25/11/2023.
//

import Foundation

public struct TestConfiguration {
    static var baseURL = "https://api.example.com"
    static var apiKey = "test_api_key"
    
   public static func configure(baseURL: String, apiKey: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
    
}
