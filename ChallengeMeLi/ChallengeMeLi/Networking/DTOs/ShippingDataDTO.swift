//
//  ShippingDataDTO.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//

public struct ShippingDataDTO: Decodable {
    public let storePickUp: Bool
    public let freeShipping: Bool
    
    public enum CodingKeys: String, CodingKey {
        case storePickUp = "store_pick_up"
        case freeShipping = "free_shipping"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.storePickUp = try container.decode(Bool.self, forKey: .storePickUp)
        self.freeShipping = try container.decode(Bool.self, forKey: .freeShipping)
    }
}
