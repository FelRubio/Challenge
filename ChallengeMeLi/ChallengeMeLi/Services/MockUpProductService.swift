//
//  MockUpProductService.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//

public struct MockUpProductService: ProductServiceProtocol {
    public func fetchProducts(completion: @escaping (Result<[Product], ProductServiceError>) -> Void) {
        let mockProducts = (1...20).map { _ in Product.random() }
        
        completion(.success(mockProducts))
    }
}
