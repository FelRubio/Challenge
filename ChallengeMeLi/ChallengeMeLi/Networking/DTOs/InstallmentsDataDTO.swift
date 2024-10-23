//
//  InstallmentsDataDTO.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//

public struct InstallmentsDataDTO: Decodable {
    public let quantity: Int
    public let amount: Double
    public let currencyId: String
    
    public enum CodingKeys: String, CodingKey {
        case quantity
        case amount
        case currencyId = "currency_id"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.quantity = try container.decode(Int.self, forKey: .quantity)
        self.amount = try container.decode(Double.self, forKey: .amount)
        self.currencyId = try container.decode(String.self, forKey: .currencyId)
    }
}
