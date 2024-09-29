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
        //Given
        let dbCharacter1: DBCharacter = DBCharacter(name: "", photo: "", id: "", description: "", favorite: false, hero: nil)
        
        let expectedCharacterArray: [DBCharacter] = [dbCharacter1]
        
        //When
        sut.setCharacterList(expectedCharacterArray)
        
        //Then
        XCTAssertEqual(expectedCharacterArray, sut.characterList)
    }
    
    func test_getCharacterList_success() {
        //Given
        let dbCharacter1: DBCharacter = DBCharacter(name: "", photo: "", id: "", description: "", favorite: false, hero: nil)
        
        let expectedCharacterArray: [DBCharacter] = [dbCharacter1]
        sut.characterList = expectedCharacterArray
        
        //When
        let recievedCharacterArray = sut.getCharacters()
        
        //Then
        XCTAssertEqual(expectedCharacterArray, recievedCharacterArray)
    }
    
    func test_getCharacterByName_success() {
        //Given
        let dbCharacter1: DBCharacter = DBCharacter(name: "", photo: "", id: "", description: "", favorite: false, hero: nil)
        let expectedCharacter: DBCharacter = DBCharacter(name: "a", photo: "a", id: "a", description: "a", favorite: true, hero: nil)
        
        let characterArray: [DBCharacter] = [dbCharacter1, expectedCharacter]
        sut.characterList = characterArray
        
        //When
        let recievedCharacter = sut.getCharacterByName("a")
        
        //Then
        XCTAssertEqual(expectedCharacter, recievedCharacter)
        XCTAssertNotEqual(dbCharacter1, recievedCharacter)
    }
    
    func test_getCharacterByID_success() {
        //Given
        let dbCharacter1: DBCharacter = DBCharacter(name: "", photo: "", id: "", description: "", favorite: false, hero: nil)
        let expectedCharacter: DBCharacter = DBCharacter(name: "a", photo: "a", id: "a", description: "a", favorite: true, hero: nil)
        
        let characterArray: [DBCharacter] = [dbCharacter1, expectedCharacter]
        sut.characterList = characterArray
        
        //When
        let recievedCharacter = sut.getCharacterByID("a")
        
        //Then
        XCTAssertEqual(expectedCharacter, recievedCharacter)
        XCTAssertNotEqual(dbCharacter1, recievedCharacter)
    }
}
