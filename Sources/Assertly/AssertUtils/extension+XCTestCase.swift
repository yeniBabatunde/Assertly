//
//  extension+XCTestCase.swift
//  Assertly
//
//  Created by Sharon Omoyeni Babatunde on 25/11/2023.
//

import Foundation
import XCTest

public extension XCTestCase {
    func waitForAsyncOperation(_ timeout: TimeInterval = 5, operation: @escaping (@escaping () -> Void) -> Void) {
        let expectation = self.expectation(description: "Async operation")
        operation {
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
}
