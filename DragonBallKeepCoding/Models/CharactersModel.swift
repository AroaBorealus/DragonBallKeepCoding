//
//  CharactersModel.swift
//  DragonBallKeepCoding
//
//  Created by Aroa Miguel Garcia on 23/9/24.
//

import Foundation

final class CharactersModel {
    static let shared = CharactersModel()
    
    var characterList: [DBCharacter]
    
    init() { self.characterList = [] }
    
    func setCharacterList(_ characters: [DBCharacter]){
        self.characterList = characters
    }
    
    func getCharacters() -> [DBCharacter]{
        return self.characterList
    }
    
    func getCharacterByName(_ name: String) -> DBCharacter?{
        characterList.first(where: { $0.name == name })
    }
    
    func getCharacterByID(_ id: String) -> DBCharacter?{
        characterList.first(where: { $0.id == id })
    }
}
