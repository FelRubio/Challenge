//
//  ShippingData.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//


/// Represents shipping data for a product.
public struct ShippingData {
    /// Indicates whether store pickup is available.
    public let storePickUp: Bool
    /// Indicates whether free shipping is available.
    public let freeShipping: Bool

    /// Initializes a new instance of `ShippingData`.
    /// - Parameters:
    ///   - storePickUp: Indicates whether store pickup is available.
    ///   - freeShipping: Indicates whether free shipping is available.
    public init(storePickUp: Bool, freeShipping: Bool) {
        self.storePickUp = storePickUp
        self.freeShipping = freeShipping
    }
    
    /// Generates a sample `ShippingData` instance with random data.
    /// - Returns: A `ShippingData` instance with random data.
    public static func random() -> ShippingData {
        return ShippingData(
            storePickUp: Bool.random(),
            freeShipping: Bool.random()
        )
    }
}
