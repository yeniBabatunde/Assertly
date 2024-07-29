//
//  MockViewModel.swift
//  AssertlyTests
//
//  Created by Sharon Omoyeni Babatunde on 06/07/2024.
//

import Foundation

public class MockViewModel: ViewModelProtocol {
    
    public var title: String = "Mock Title"
    public var mockResults: [String: Any] = [:]
    public var mockErrors: [String: Error] = [:]
    
    public func performAction<T>(_ action: String, completion: @escaping (Result<T, Error>) -> Void) {
        if let error = mockErrors[action] {
            completion(.failure(error))
        } else if let result = mockResults[action] as? T {
            completion(.success(result))
        } else {
            fatalError("No mock result or error set for action: \(action)")
        }
    }
    
    public func performAction<R: Codable>(_ action: String, completion: @escaping (Result<R, Error>) -> Void) {
        if let result = mockResults[action] as? R {
            completion(.success(result))
        } else if let error = mockErrors[action] {
            completion(.failure(error))
        } else {
            fatalError("No mock result or error set for action: \(action)")
        }
    }
    
    public func setMockResult<R>(_ result: R, for action: String) {
        mockResults[action] = result
    }
    
    public func setMockResult<R: Codable>(_ result: R, for action: String) {
        mockResults[action] = result
    }
    
    public func setMockError(_ error: Error, for action: String) {
        mockErrors[action] = error
    }
    
    // Helper methods for common types
    public func setMockArrayResult<R: Codable>(_ result: [R], for action: String) {
        mockResults[action] = result
    }
    
    public func setMockArrayResult<R>(_ result: [R], for action: String) {
        mockResults[action] = result
    }
    
    public func setMockDictionaryResult<U: Codable>(_ result: [U: Any], for action: String) {
        mockResults[action] = result
    }
    
    public func setMockDictionaryResult<U>(_ result: [U: Any], for action: String) {
        mockResults[action] = result
    }
}

//MARK: Extension to handle array results
public extension MockViewModel {
    
    func performArrayAction<R: Codable>(_ action: String, completion: @escaping (Result<[R], Error>) -> Void) {
        if let result = mockResults[action] as? [R] {
            completion(.success(result))
        } else if let error = mockErrors[action] {
            completion(.failure(error))
        } else {
            fatalError("No mock array result or error set for action: \(action)")
        }
    }
    
    func performArrayAction<R>(_ action: String, completion: @escaping (Result<[R], Error>) -> Void) {
        if let result = mockResults[action] as? [R] {
            completion(.success(result))
        } else if let error = mockErrors[action] {
            completion(.failure(error))
        } else {
            fatalError("No mock array result or error set for action: \(action)")
        }
    }
    
}

//MARK: Extension to handle dictionary results
public extension MockViewModel {
    
    func performDictionaryAction<Key: Hashable, Value>(_ action: String, completion: @escaping (Result<[Key: Value], Error>) -> Void) {
        if let result = mockResults[action] as? [Key: Value] {
            completion(.success(result))
        } else if let error = mockErrors[action] {
            completion(.failure(error))
        } else {
            fatalError("No mock dictionary result or error set for action: \(action)")
        }
    }
}
