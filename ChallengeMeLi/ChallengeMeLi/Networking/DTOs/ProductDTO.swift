//
//  ProductDTO.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//

public struct ProductDTO: Decodable {
    public let id: String
    public let title: String
    public let condition: String
    public let thumbnail: String
    public let currencyId: String
    public let price: Int
    public let originalPrice: Int?
    public let shipping: ShippingDataDTO
    public let installments: InstallmentsDataDTO
    public let availableQuantity: Int
    
    public enum CodingKeys: String, CodingKey {
        case id
        case title
        case condition
        case thumbnail
        case currencyId = "currency_id"
        case price
        case originalPrice = "original_price"
        case shipping
        case installments
        case availableQuantity = "available_quantity"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.condition = try container.decode(String.self, forKey: .condition)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
        self.currencyId = try container.decode(String.self, forKey: .currencyId)
        self.price = try container.decode(Int.self, forKey: .price)
        self.originalPrice = try container.decodeIfPresent(Int.self, forKey: .originalPrice)
        self.shipping = try container.decode(ShippingDataDTO.self, forKey: .shipping)
        self.installments = try container.decode(InstallmentsDataDTO.self, forKey: .installments)
        self.availableQuantity = try container.decode(Int.self, forKey: .availableQuantity)
    }
}
