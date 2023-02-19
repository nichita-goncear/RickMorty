//
//  CharacterModel.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 17.02.2023.
//

import Foundation
import UIKit

enum CharacterStatus: String, Decodable {
    case alive
    case dead
    case unknown
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let status = try? container.decode(String.self)
        switch status {
        case "Alive": self = .alive
        case "Dead": self = .dead
        case "unknown": self = .unknown
        default:
            self = .unknown
        }
    }
}

struct CharacterList: Decodable {
    let results: [CharacterModel]
}

struct CharacterModel: Decodable {
    let name: String
    let status: CharacterStatus
    let origin: CharacterOriginModel
    let imageUrlString: String
    let species: String
    
    struct CharacterOriginModel: Decodable {
        let name: String
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case status
        case origin
        case imageUrlString = "image"
        case species
    }
}
