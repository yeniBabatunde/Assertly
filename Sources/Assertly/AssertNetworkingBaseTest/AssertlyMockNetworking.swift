//
//  MockNetworking.swift
//  Assertly
//
//  Created by Sharon Omoyeni Babatunde on 06/03/2024.
//

import Foundation

open class MockNetworking: NetworkingProtocol {
   public var mockResult: Result<Decodable, Error>?
    
    public func request<T: Decodable>(_ endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let result = mockResult as? Result<T, Error> else {
            fatalError("Mock result not set or of incorrect type")
        }
        completion(result)
    }
}
