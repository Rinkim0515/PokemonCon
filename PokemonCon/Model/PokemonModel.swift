//
//  PokemonModel.swift
//  PokemonCon
//
//  Created by bloom on 7/15/24.
//

import Foundation



import Foundation


struct PokemonModel: Codable {
    
    let sprites: Sprites
    

}

struct Sprites: Codable {
    
    let frontDefault: String?
    

    enum CodingKeys: String, CodingKey {
        
        case frontDefault = "front_default"
        
    }

}


