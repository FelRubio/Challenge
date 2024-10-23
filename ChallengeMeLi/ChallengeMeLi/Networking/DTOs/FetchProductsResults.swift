//
//  FetchProductsResults.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//

public struct FetchProductsResults: Decodable {
    public let results: DecodableList<ProductDTO>
}
