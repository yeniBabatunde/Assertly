//
//  AssertlyViewModelProtocol.swift
//  Assertly
//
//  Created by Sharon Omoyeni Babatunde on 06/07/2024.
//

import Foundation

public protocol ViewModelProtocol {
    
    var title: String { get }
    var mockResults: [String: Any] { get }
    var mockErrors: [String: Error] { get }

}
