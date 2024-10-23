//
//  DescriptionDTO.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//

public struct DescriptionDTO: Decodable {
    public let text: String
    
    public enum CodingKeys: String, CodingKey {
        case text = "plain_text"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try container.decode(String.self, forKey: .text)
    }
}
