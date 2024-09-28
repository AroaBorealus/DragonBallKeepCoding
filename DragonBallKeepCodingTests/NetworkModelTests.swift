//
//  DragonBallKeepCodingTests.swift
//  DragonBallKeepCodingTests
//
//  Created by Aroa Miguel Garcia on 10/9/24.
//

import XCTest
@testable import DragonBallKeepCoding

final class NetworkModelTests: XCTestCase {
    private var sut: NetworkModel!
    private var mock: APIClientProtocolMock<[DBCharacter]>!
    
    //Creamos el estado por defecto del Testing
    override func setUp() {
        super.setUp()
        mock = APIClientProtocolMock()
        sut = NetworkModel(client: mock)
    }
    
    
    func test_getAllCharacters_success() {
        //Given
        let expectedResult = Result<[DBCharacter], DBError>.success([])
        mock.recievedResultCharacters = expectedResult
        sut.setToken("Lorem Ipsum")
        var recievedResult: Result<[DBCharacter], DBError>?
        
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dragonball.keepcoding.education"
        components.path = "/api/heros/all"
        let url = components.url!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer Lorem Ipsum", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let json: [String: Any] = ["name" : ""]
        let jsonData = try! JSONSerialization.data(withJSONObject: json)
        urlRequest.httpBody = jsonData
        
        //When
        sut.getAllCharacters("", completion: { result in
            recievedResult = result
        })
        
        //Then
        XCTAssertEqual(urlRequest, mock.recievedRequest)
        XCTAssertEqual(expectedResult, recievedResult)
        XCTAssert(mock.didCallRequestCharacters)
        XCTAssertFalse(mock.didCallRequestLogin)
    }
    
    func test_getAllCharacters_missingToken() {
        let expectedResult = Result<[DBCharacter], DBError>.failure(DBError.missingToken)
        var recievedResult: Result<[DBCharacter], DBError>?
        //When
        sut.getAllCharacters("", completion: { result in
            recievedResult = result
        })
        
        //Then
        XCTAssertEqual(expectedResult, recievedResult)
        XCTAssertNil(mock.recievedRequest)
        XCTAssertFalse(mock.didCallRequestCharacters)
        XCTAssertFalse(mock.didCallRequestLogin)
    }
    
    func test_loginRequest_success() {
        let expectedResult = Result<String, DBError>.success("gvctfxc")
        mock.recievedResultLogin = expectedResult
        var recievedResult: Result<String, DBError>?
        
        
        sut.loginRequest("somemail@gmail.com", "Qwerty1", completion: { result in
            recievedResult = result
        })
        
        XCTAssertEqual(recievedResult, expectedResult)
        XCTAssertTrue(mock.didCallRequestLogin)
        XCTAssertFalse(mock.didCallRequestCharacters)
    }
    
    func test_loginRequest_fail() {
        let expectedResult = Result<String, DBError>.failure(DBError.noData)
        mock.recievedResultLogin = expectedResult
        var recievedResult: Result<String, DBError>?
        
        
        sut.loginRequest("", "", completion: { result in
            recievedResult = result
        })
        
        XCTAssertEqual(recievedResult, expectedResult)
        XCTAssertFalse(mock.didCallRequestLogin)
        XCTAssertFalse(mock.didCallRequestCharacters)
    }
    
    func test_getTransformations_success() {
        let expectedResult = Result<[DBCharacter], DBError>.success([])
        mock.recievedResultCharacters = expectedResult
        var recievedResult: Result<[DBCharacter], DBError>?
        sut.setToken("Lorem Ipsum")
        let requestedCharacterId = "1234"
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dragonball.keepcoding.education"
        components.path = "/api/heros/tranformations"
        let url = components.url!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer Lorem Ipsum", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let json: [String: Any] = ["id" : requestedCharacterId]
        let jsonData = try! JSONSerialization.data(withJSONObject: json)
        urlRequest.httpBody = jsonData
        
        
        sut.getTransformations(requestedCharacterId, completion: { result in
            recievedResult = result
        })
        
        XCTAssertEqual(expectedResult, recievedResult)
        XCTAssertEqual(urlRequest, mock.recievedRequest)
        XCTAssertTrue(mock.didCallRequestCharacters)
        XCTAssertFalse(mock.didCallRequestLogin)
    }
    
    func test_getTransformations_failure() {
        let expectedResult = Result<[DBCharacter], DBError>.failure(DBError.unknown)
        mock.recievedResultCharacters = expectedResult
        var recievedResult: Result<[DBCharacter], DBError>?
        sut.setToken("Lorem Ipsum")
        let requestedCharacterId = "1234"
        
        
        sut.getTransformations(requestedCharacterId, completion: { result in
            recievedResult = result
        })
        
        XCTAssertEqual(expectedResult, recievedResult)
        XCTAssertTrue(mock.didCallRequestCharacters)
        XCTAssertFalse(mock.didCallRequestLogin)
    }
    
}
