//
//  PictureDTO.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//

public struct PictureDTO: Decodable {
//    public let id: String
    public let url: String
    public let secureURL: String
    
    public enum CodingKeys: String, CodingKey {
//        case id
        case url
        case secureURL = "secure_url"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
        self.url = try container.decode(String.self, forKey: .url)
        self.secureURL = try container.decode(String.self, forKey: .secureURL)
    }
}
