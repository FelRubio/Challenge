//
//  ProductServiceError.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//


public enum ProductServiceError: Error {
    case decodingError(Error)
    case invalidURL
    case invalidResponse
    case networkError(Error)
}
