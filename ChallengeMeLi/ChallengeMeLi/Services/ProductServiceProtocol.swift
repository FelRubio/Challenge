//
//  ProductServiceProtocol.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//

public protocol ProductServiceProtocol {
    func getProducts(completion: @escaping (Result<[Product], Error>) -> Void)
}
