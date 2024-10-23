//
//  DecodableList.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//

/// `DecodableList` is a generic structure designed to handle the decoding of lists of
/// elements that conform to the `Decodable` protocol.
/// It provides a mechanism to continue decoding the list even if some list elements cannot
/// be decoded, by ignoring those elements.
///
/// Can be used with any type that conforms to the `Decodable` protocol.
public struct DecodableList<T: Decodable>: Decodable {
    public let elements: [T]

    private struct Dummy: Decodable { }

    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var elements = [T]()

        while !container.isAtEnd {
            if let element = try? container.decode(T.self) {
                elements.append(element)
            } else {
                _ = try? container.decode(Dummy.self)
            }
        }
        self.elements = elements
    }
}
