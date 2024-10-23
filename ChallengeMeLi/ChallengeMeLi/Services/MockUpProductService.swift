//
//  MockUpProductService.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//
import Foundation

public struct MockUpProductService: ProductServiceProtocol {
    public func fetchProductDetail(for productId: String, completion: @escaping (Result<ProductDetail, ProductServiceError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            completion(.success(ProductDetail.random()))
        }
    }
    
    public func fetchProducts(with query: String, completion: @escaping (Result<[Product], ProductServiceError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let mockProducts = (1...20).map { _ in Product.random() }
            
            completion(.success(mockProducts))
        }
    }
    
    public func fetchProducts(completion: @escaping (Result<[Product], ProductServiceError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let mockProducts = (1...20).map { _ in Product.random() }
            
            completion(.success(mockProducts))
        }
    }
}
