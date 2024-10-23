//
//  String+URL.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//

import Foundation

extension String {
    func convertToHTTPS() -> String {
        guard var urlComponents = URLComponents(string: self) else {
            return self
        }
        urlComponents.scheme = "https"
        return urlComponents.string ?? self
    }
}
