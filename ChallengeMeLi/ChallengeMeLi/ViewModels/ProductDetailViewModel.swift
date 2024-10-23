//
//  ProductDetailViewModel.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//


import Foundation

class ProductDetailViewModel {
    private let productService: ProductServiceProtocol
    var productDetail: ProductDetail?
    
    init(productService: ProductServiceProtocol = ProductService()) {
        self.productService = productService
    }
    
    func fetchProductDetail(for productId: String, completion: @escaping (Result<ProductDetail, ProductServiceError>) -> Void) {
        productService.fetchProductDetail(for: productId) { result in
            switch result {
            case .success(let productDetail):
                self.productDetail = productDetail
                completion(.success(productDetail))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
