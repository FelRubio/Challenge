//
//  ProductDetailDTO.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//

public struct ProductDetailDTO: Decodable {
    public let id: String
    public let name: String
    public let attributes: [ProductAttributeDTO]
    public let pictures: [PictureDTO]
    public let warranty: String?
    public let description: String?
    public let condition: String
    
    public enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case attributes
        case pictures
        case warranty
        case description
        case condition
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.attributes = try container.decode([ProductAttributeDTO].self, forKey: .attributes)
        self.pictures = try container.decode([PictureDTO].self, forKey: .pictures)
        self.warranty = try container.decodeIfPresent(String.self, forKey: .warranty)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.condition = try container.decode(String.self, forKey: .condition)
    }
}
