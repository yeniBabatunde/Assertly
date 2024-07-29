//
//  AssertlyNetworkingProtocol.swift
//  Assertly
//
//  Created by Sharon Omoyeni Babatunde on 06/07/2024.
//

import Foundation

public protocol NetworkingProtocol {
    func request<T: Decodable>(_ endpoint: String, completion: @escaping (Result<T, Error>) -> Void)
}

