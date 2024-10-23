//
//  DoubleCurrencyFormat.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//

import Foundation

extension Double {
    /// Helper to quickly formate a Double into a formatted string currency.
    /// - Parameter code: currrency code e.g. COP, USD...
    /// - Returns: Formatted String ($00.000)
    func currencyFormatted(code: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = code
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        
        return formatter.string(from: NSNumber(value: self)) ?? "$0.00)"
    }
}
