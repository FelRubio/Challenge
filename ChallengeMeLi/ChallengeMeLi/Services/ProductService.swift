//
//  ProductService.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//

import Foundation

public struct ProductService: ProductServiceProtocol {
    private let urlSession: URLSession
    private let apiEndpoint = "https://api.mercadolibre.com/"
    
    public init() {
        self.urlSession = URLSession.shared
    }
    
    public func fetchProducts(completion: @escaping (Result<[Product], ProductServiceError>) -> Void) {
        guard var urlComponents = URLComponents(string: apiEndpoint.appending("sites/MCO/search")) else {
            completion(.failure(.invalidURL))
            return
        }
        
        urlComponents.queryItems = [
            .init(name: "status", value: "active"),
            .init(name: "q", value: "promotions")
        ]
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidResponse))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = urlSession.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(FetchProductsResults.self, from: data)
                
                let products = response.results.elements.map { product in
                    return Product(
                        id: product.id,
                        title: product.title,
                        thumbnailURL: product.thumbnail.convertToHTTPS(),
                        price: product.price,
                        originalPrice: product.originalPrice,
                        currencyId: product.currencyId,
                        condition: product.condition,
                        quantityAvailable: product.availableQuantity,
                        shippingData: .init(storePickUp: product.shipping.storePickUp, freeShipping: product.shipping.freeShipping),
                        installmentsData: .init(quantity: product.installments.quantity, amount: product.installments.amount, currencyId: product.installments.currencyId)
                    )
                }
                
                completion(.success(products))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        
        task.resume()
    }
    
    public func fetchProducts(with query: String, completion: @escaping (Result<[Product], ProductServiceError>) -> Void) {
        guard var urlComponents = URLComponents(string: apiEndpoint.appending("sites/MCO/search")) else {
            completion(.failure(.invalidURL))
            return
        }
        
        urlComponents.queryItems = [
            .init(name: "status", value: "active"),
            .init(name: "q", value: query)
        ]
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidResponse))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = urlSession.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(FetchProductsResults.self, from: data)
                
                let products = response.results.elements.map { product in
                    return Product(
                        id: product.id,
                        title: product.title,
                        thumbnailURL: product.thumbnail.convertToHTTPS(),
                        price: product.price,
                        originalPrice: product.originalPrice,
                        currencyId: product.currencyId,
                        condition: product.condition,
                        quantityAvailable: product.availableQuantity,
                        shippingData: .init(storePickUp: product.shipping.storePickUp, freeShipping: product.shipping.freeShipping),
                        installmentsData: .init(quantity: product.installments.quantity, amount: product.installments.amount, currencyId: product.installments.currencyId)
                    )
                }
                
                completion(.success(products))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        
        task.resume()
    }
    
    public func fetchProductDetail(for productId: String, completion: @escaping (Result<ProductDetail, ProductServiceError>) -> Void) {
        guard let url = URL(string: apiEndpoint.appending("/items/" + productId)) else {
            completion(.failure(.invalidURL))
            return
        }
        let dispatchGroup = DispatchGroup()
        
        var productResponse: ProductDetailDTO?
        var productDescription: String?
        var fetchError: ProductServiceError?
        
        dispatchGroup.enter()
        let task = urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                fetchError = .networkError(error)
                dispatchGroup.leave()
                return
            }
            
            guard let data = data else {
                fetchError = .invalidResponse
                dispatchGroup.leave()
                return
            }
            
            do {
                productResponse = try JSONDecoder().decode(ProductDetailDTO.self, from: data)
            } catch {
                fetchError = .decodingError(error)
            }
            dispatchGroup.leave()
        }
        
        task.resume()
        
        dispatchGroup.enter()
        getDescription(for: productId) { description in
            productDescription = description
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            if let error = fetchError {
                completion(.failure(error))
                return
            }
            
            guard let productResponse = productResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            let attributes: [ProductAttribute] = productResponse.attributes.compactMap { attribute in
                guard let value = attribute.value else { return nil }
                return ProductAttribute(id: UUID().uuidString, name: attribute.name, value: value)
            }
            
            let productDetail = ProductDetail(
                id: productResponse.id,
                name: productResponse.name,
                attributes: attributes,
                pictures: productResponse.pictures.compactMap { URL(string: $0.secureURL) },
                description: productDescription ?? ""
            )
            
            completion(.success(productDetail))
        }
    }
    
    public func getDescription(for productId: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: apiEndpoint.appending(productId + "/description/")) else {
            completion(nil)
            return
        }
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(DescriptionDTO.self, from: data)
                print(response)
                let description = response.text
                completion(description)
            } catch {
                completion(nil)
            }
        }
        
        task.resume()
    }
}
