//
//  InstallmentsData.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//


/// Represents installment payment data for a product.
public struct InstallmentsData {
    /// The number of installments.
    public let quantity: Int
    /// The amount for each installment.
    public let amount: Double
    /// The currency ID for the installment amount.
    public let currencyId: String

    /// Initializes a new instance of `InstallmentsData`.
    /// - Parameters:
    ///   - quantity: The number of installments.
    ///   - amount: The amount for each installment.
    ///   - currencyId: The currency ID for the installment amount.
    public init(quantity: Int, amount: Double, currencyId: String) {
        self.quantity = quantity
        self.amount = amount
        self.currencyId = currencyId
    }
    
    /// Generates a sample `InstallmentsData` instance with random data.
    /// - Returns: An `InstallmentsData` instance with random data.
    public static func random() -> InstallmentsData {
        return InstallmentsData(
            quantity: Int.random(in: 1...24),
            amount: Double.random(in: 10...1000),
            currencyId: ["USD", "EUR", "GBP"].randomElement()!
        )
    }
}
