//
//  ProductServiceTests.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//

import XCTest
@testable import ChallengeMeLi

class MockUpProductServiceTests: XCTestCase {
    var productService: MockUpProductService!
    
    override func setUp() {
        super.setUp()
        productService = MockUpProductService()
    }
    
    override func tearDown() {
        productService = nil
        super.tearDown()
    }
    
    func testFetchProducts() {
        // Arrange
        
        
        // Act
        var productResult: Result<[Product], ProductServiceError>?
        productService.fetchProducts { result in
            productResult = result
        }
        
        // Assert
        switch productResult {
        case .success(let products):
            XCTAssertFalse(products.isEmpty)
        case .failure(let error):
            XCTFail("Expected success, but got failure with error: \(error)")
        case nil:
            XCTFail("Expected success, but got no results")

        }
    }
}
