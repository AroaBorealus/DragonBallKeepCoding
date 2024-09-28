//
//  CharactersModelTests.swift
//  DragonBallKeepCodingTests
//
//  Created by Aroa Miguel Garcia on 28/9/24.
//
import XCTest
@testable import DragonBallKeepCoding

final class CharactersModelTests: XCTestCase{
    private var sut: CharactersModel!
    
    override func setUp() {
        super.setUp()
        sut = CharactersModel()
    }
    
    
    func test_setCharacterList_success() {
        let dbCharacter1: DBCharacter = DBCharacter(name: "", photo: "", id: "", description: "", favorite: false, hero: nil)
        
        let expectedCharacterArray: [DBCharacter] = [dbCharacter1]
        
        sut.setCharacterList(expectedCharacterArray)
        
        XCTAssertEqual(expectedCharacterArray, sut.characterList)
    }
    
    func test_getCharacterList_success() {
        let dbCharacter1: DBCharacter = DBCharacter(name: "", photo: "", id: "", description: "", favorite: false, hero: nil)
        
        let expectedCharacterArray: [DBCharacter] = [dbCharacter1]
        
        sut.characterList = expectedCharacterArray
        
        let recievedCharacterArray = sut.getCharacters()
        
        XCTAssertEqual(expectedCharacterArray, recievedCharacterArray)
    }
    
    func test_getCharacterByName_success() {
        let dbCharacter1: DBCharacter = DBCharacter(name: "", photo: "", id: "", description: "", favorite: false, hero: nil)
        let expectedCharacter: DBCharacter = DBCharacter(name: "a", photo: "a", id: "a", description: "a", favorite: true, hero: nil)
        
        let characterArray: [DBCharacter] = [dbCharacter1, expectedCharacter]
        sut.characterList = characterArray
        
        let recievedCharacter = sut.getCharacterByName("a")
        
        XCTAssertEqual(expectedCharacter, recievedCharacter)
        XCTAssertNotEqual(dbCharacter1, recievedCharacter)
    }
}
