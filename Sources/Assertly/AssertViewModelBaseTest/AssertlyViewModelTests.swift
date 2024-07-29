//
//  ViewModelTests.swift
//  AssertlyTests
//
//  Created by Sharon Omoyeni Babatunde on 06/07/2024.
//

import XCTest

public class AssertlyViewModelTests<T: ViewModelProtocol>: XCTestCase {
    
    public var sut: T?
    
    public override func setUp() {
        super.setUp()
        sut = createDependencies()
    }
    
    public override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    public func createDependencies() -> T {
        fatalError("Override \("createDependencies") this method in subclass")
    }
    
    public func testAction<R: Equatable>(_ action: String, expectedResult: R) {
        let expectation = self.expectation(description: "Test \(action)")
        
        (sut as? MockViewModel)?.performAction(action) { (result: Result<R, Error>) in
            switch result {
            case .success(let value):
                XCTAssertEqual(value, expectedResult)
            case .failure:
                XCTFail("Expected success, got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    public func testArrayAction<Element: Equatable>(_ action: String, expectedResult: [Element]) {
        let expectation = self.expectation(description: "Test Array \(action)")
        
        (sut as? MockViewModel)?.performArrayAction(action) { (result: Result<[Element], Error>) in
            switch result {
            case .success(let value):
                XCTAssertEqual(value, expectedResult)
            case .failure:
                XCTFail("Expected success, got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    public func testDictionaryAction<Key: Hashable & Equatable, Value: Equatable>(_ action: String, expectedResult: [Key: Value]) {
        let expectation = self.expectation(description: "Test Dictionary \(action)")
        
        (sut as? MockViewModel)?.performDictionaryAction(action) { (result: Result<[Key: Value], Error>) in
            switch result {
            case .success(let value):
                XCTAssertEqual(value, expectedResult)
            case .failure:
                XCTFail("Expected success, got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    public func testActionError<R>(_ action: String, expectedError: Error, as type: R.Type) {
        let expectation = self.expectation(description: "Test \(action) Error")
        
        (sut as? MockViewModel)?.performAction(action) { (result: Result<R, Error>) in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, expectedError.localizedDescription)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    public func assertElementProperties<R: Equatable>(
        in viewController: UIViewController,
        elements: [String: (getter: () -> R?, expectedValue: R)]
    ) {
        for (elementName, (getter, expectedValue)) in elements {
            guard let actualValue = getter() else {
                XCTFail("Element \(elementName) not found in view controller or its value is nil")
                continue
            }
            
            XCTAssertEqual(actualValue, expectedValue, "Property for \(elementName) does not match expected value")
        }
    }
    
    public func assertElementProperties<R: UIView, V: Equatable>(
        in viewController: UIViewController,
        elements: [String: (keyPath: KeyPath<R, V>, expectedValue: V)]
    ) {
        for (elementName, (keyPath, expectedValue)) in elements {
            guard let element = viewController.value(forKey: elementName) as? R else {
                XCTFail("Element \(elementName) not found in view controller or is not of expected type")
                continue
            }
            
            let actualValue = element[keyPath: keyPath]
            XCTAssertEqual(actualValue, expectedValue, "Property for \(elementName) (\(T.self)) does not match expected value")
        }
    }
    
    public func assertBoolean(_ getter: @escaping () -> Bool, expectedValue: Bool, message: String? = nil) {
        let actualValue = getter()
        if expectedValue {
            XCTAssertTrue(actualValue, message ?? "Expected true, but got false")
        } else {
            XCTAssertFalse(actualValue, message ?? "Expected false, but got true")
        }
    }
    
    public func assertNotNil<V>(_ expression: @autoclosure () -> V?,
                                _ message: @autoclosure () -> String = "",
                                file: StaticString = #file,
                                line: UInt = #line) {
        let value = expression()
        XCTAssertNotNil(value, message(), file: file, line: line)
    }
    
    @discardableResult
    public func assertNotNilAndUnwrap<V>(_ expression: @autoclosure () -> V?,
                                         _ message: @autoclosure () -> String = "",
                                         file: StaticString = #file,
                                         line: UInt = #line) -> V? {
        let value = expression()
        XCTAssertNotNil(value, message(), file: file, line: line)
        return value
    }
    
    public func assertEqual<V: Equatable>(_ expression1: @autoclosure () -> V,
                                          _ expression2: @autoclosure () -> V,
                                          _ message: @autoclosure () -> String = "",
                                          file: StaticString = #file,
                                          line: UInt = #line) {
        let value1 = expression1()
        let value2 = expression2()
        XCTAssertEqual(value1, value2, message(), file: file, line: line)
    }
    
    public func assertEqualOptional<V: Equatable>(_ expression1: @autoclosure () -> V?,
                                                  _ expression2: @autoclosure () -> V?,
                                                  _ message: @autoclosure () -> String = "",
                                                  file: StaticString = #file,
                                                  line: UInt = #line) {
        let value1 = expression1()
        let value2 = expression2()
        XCTAssertEqual(value1, value2, message(), file: file, line: line)
    }
    
    public func assertTrue(_ expression: @autoclosure () -> Bool,
                           _ message: @autoclosure () -> String = "",
                           file: StaticString = #file,
                           line: UInt = #line) {
        let value = expression()
        XCTAssertTrue(value, message(), file: file, line: line)
    }
    
    public func assertFalse(_ expression: @autoclosure () -> Bool,
                            _ message: @autoclosure () -> String = "",
                            file: StaticString = #file,
                            line: UInt = #line) {
        let value = expression()
        XCTAssertFalse(value, message(), file: file, line: line)
    }
    
    public func assertNotEqual<V: Equatable>(_ expression1: @autoclosure () -> V,
                                             _ expression2: @autoclosure () -> V,
                                             _ message: @autoclosure () -> String = "",
                                             file: StaticString = #file,
                                             line: UInt = #line) {
        let value1 = expression1()
        let value2 = expression2()
        XCTAssertNotEqual(value1, value2, message(), file: file, line: line)
    }

    public func assertNotIdentical(_ expression1: @autoclosure () -> AnyObject?,
                                   _ expression2: @autoclosure () -> AnyObject?,
                                   _ message: @autoclosure () -> String = "",
                                   file: StaticString = #file,
                                   line: UInt = #line) {
        let value1 = expression1()
        let value2 = expression2()
        XCTAssertNotIdentical(value1, value2, message(), file: file, line: line)
    }
  
    public func assertNoThrow<V>(_ expression: @autoclosure () throws -> V,
                                 _ message: @autoclosure () -> String = "",
                                 file: StaticString = #file,
                                 line: UInt = #line) {
        XCTAssertNoThrow(try expression(), message(), file: file, line: line)
    }
}
