//
//  ProductViewModel.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//

public class ProductViewModel {
    var products: [Product] = []
    
    private let productService: ProductServiceProtocol
    
    public init() {
        self.productService = MockUpProductService()
    }
    
    public init(productService: ProductServiceProtocol) {
        self.productService = productService
    }
    
    func fetchInitialProducts(completion: @escaping () -> Void) {
        productService.fetchProducts { result in
            switch result {
            case .success(let products):
                self.products = products
                completion()
            case .failure:
                self.products = []
                completion()
            }
        }
    }
    
    func searchProducts(with query: String, completion: @escaping () -> Void) {
        if query.isEmpty {
            fetchInitialProducts(completion: completion)
        } else {
            productService.fetchProducts(with: query) { result in
                switch result {
                case .success(let products):
                    self.products = products
                    completion()
                case .failure:
                    self.products = []
                    completion()
                }
            }
        }
    }
}
