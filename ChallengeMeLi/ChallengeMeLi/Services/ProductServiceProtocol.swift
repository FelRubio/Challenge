//
//  ProductServiceProtocol.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//

public protocol ProductServiceProtocol {
    func fetchProducts(completion: @escaping (Result<[Product], ProductServiceError>) -> Void)
}
