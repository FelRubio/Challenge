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
    
    public static func random() -> ProductDetail {
        return ProductDetail(
            id: UUID().uuidString,
            name: "Sample Product \(Int.random(in: 1...1000))",
            attributes: [],
            pictures: Array(repeating: URL(string: "https://picsum.photos/200")!, count: Int.random(in: 3...5)),
            description: """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla in turpis et enim tempus hendrerit. Vestibulum tincidunt ultricies odio, sed feugiat lorem scelerisque vitae. Vivamus at augue lectus. Duis quis tempus dui. Nullam id tincidunt justo, eu tempor leo. Donec nisl metus, interdum at efficitur ut, cursus in nisi. Ut ut mauris risus. Donec malesuada augue a gravida lobortis. Sed at est tempor, tincidunt nisl et, maximus quam. Duis tempor tempor bibendum. Sed ut arcu in libero ultrices euismod.
"""
        )
    }
}
