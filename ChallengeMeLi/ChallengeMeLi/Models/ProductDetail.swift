//
//  ProductDetail.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//

import Foundation

/// Represents detailed information about a product.
public struct ProductDetail: Identifiable {
    /// The unique identifier of the product detail.
    public let id: String
    public let name: String
    /// The attributes of the product.
    public let attributes: [ProductAttribute]
    /// The URLs of the product's pictures.
    public let pictures: [URL]
    public let description: String
    
    /// Initializes a new instance of `ProductDetail`.
    /// - Parameters:
    ///   - id: The unique identifier of the product detail.
    ///   - attributes: The attributes of the product.
    ///   - pictures: The URLs of the product's pictures.
    public init(id: String, name: String, attributes: [ProductAttribute], pictures: [URL], description: String) {
        self.id = id
        self.name = name
        self.attributes = attributes
        self.pictures = pictures
        self.description = description
    }
}
