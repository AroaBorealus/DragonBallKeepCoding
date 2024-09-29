//
//  APIClientProtocolMock.swift
//  DragonBallKeepCodingTests
//
//  Created by Aroa Miguel Garcia on 28/9/24.
//

import Foundation
@testable import DragonBallKeepCoding

final class APIClientProtocolMock<C: Codable>: APIClientProtocol{
    var session: URLSession = .shared
    
    var didCallRequestLogin: Bool = false
    var recievedRequest: URLRequest?
    var recievedResultLogin: Result<String, DBError>?
    func requestLogin(from request: URLRequest, completion: @escaping (Result<String, DBError>) -> Void) {
        didCallRequestLogin = true
        recievedRequest = request
        
        if let result = recievedResultLogin {
            completion(result)
        }
    }
    
    var didCallRequestCharacters: Bool = false
    var recievedResultCharacters: Result<C,DBError>?
    func requestCharacters<T>(_ type: T.Type, from request: URLRequest, completion: @escaping (Result<T, DBError>) -> Void) where T : Decodable {
        didCallRequestCharacters = true
        recievedRequest = request
        
        if let result = recievedResultCharacters as? Result<T, DBError> {
            completion(result)
        }
    }
}
