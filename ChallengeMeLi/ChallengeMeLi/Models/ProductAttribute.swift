//
//  ProductAttribute.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//


/// Represents an attribute of a product.
public struct ProductAttribute: Identifiable {
    /// The unique identifier of the attribute.
    public let id: String
    /// The name of the attribute.
    public let name: String
    /// The value of the attribute.
    public let value: String

    /// Initializes a new instance of `ProductAttribute`.
    /// - Parameters:
    ///   - id: The unique identifier of the attribute.
    ///   - name: The name of the attribute.
    ///   - value: The value of the attribute.
    public init(id: String, name: String, value: String) {
        self.id = id
        self.name = name
        self.value = value
    }
}
