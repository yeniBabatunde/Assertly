//
//  UnitTestableHelpers.swift
//  Assertly
//
//  Created by Sharon Omoyeni Babatunde on 25/11/2023.
//

import XCTest

// MARK: Core Framework Structure
/*
 This structure provides a foundation for our unit tests. The UnitTestable protocol ensures that all test cases have a consistent interface, while the BaseTestCase class handles setup and teardown.
 */

public protocol UnitTestable {
    associatedtype Dependencies
    init(dependencies: Dependencies)
    func setUp()
    func tearDown()
}


public class BaseTestCase<T: UnitTestable>: XCTestCase {
   public var sut: T?
    
    public override func setUp() {
        super.setUp()
        sut = T(dependencies: createDependencies())
        sut?.setUp()
    }
    
    public override func tearDown() {
        sut?.tearDown()
        sut = nil
        super.tearDown()
    }
    
   public func createDependencies() -> T.Dependencies {
        fatalError("Subclasses must implement createDependencies()")
    }
}
