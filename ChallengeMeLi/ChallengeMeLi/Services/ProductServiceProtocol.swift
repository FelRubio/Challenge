//
//  ProductServiceProtocol.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//

public protocol ProductServiceProtocol {
    func fetchProducts(completion: @escaping (Result<[Product], ProductServiceError>) -> Void)
    func fetchProducts(with query: String, completion: @escaping (Result<[Product], ProductServiceError>) -> Void)
    func fetchProductDetail(for productId: String, completion: @escaping (Result<ProductDetail, ProductServiceError>) -> Void)
}
