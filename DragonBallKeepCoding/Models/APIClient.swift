//
//  APIClient.swift
//  DragonBallKeepCoding
//
//  Created by Aroa Miguel Garcia on 23/9/24.
//

import Foundation

enum DBError: Error, Equatable {
    case noData
    case decodingFailed
    case malformedURL
    case statusCode(code: Int?)
    case unauthorized
    case missingToken
    case encryptionError
    case unknown
}

protocol APIClientProtocol {
    var session: URLSession { get }
    func requestLogin(
        from request: URLRequest,
        completion: @escaping (Result<String, DBError>) -> Void
    )
    func requestCharacters<T: Decodable>(
        _ type: T.Type,
        from request: URLRequest,
        completion: @escaping (Result<T, DBError>) -> Void
    )
}

struct APIClient: APIClientProtocol {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func requestLogin(
        from request: URLRequest,
        completion: @escaping (Result<String, DBError>) -> Void
    ) {
        let task = session.dataTask(with: request) { data, response, error in
            let result: Result<String, DBError>
            
            defer {
                completion(result)
            }
            
            guard error == nil else {
                result = .failure(.unknown)
                return
            }
            
            guard let data else {
                result = .failure(.noData)
                return
            }
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            
            guard statusCode != 401 else {
                result = .failure(.unauthorized)
                return
            }
            
            guard statusCode == 200 else {
                result = .failure(.statusCode(code: statusCode))
                return
            }
            
            guard let decodedToken =  String(data: data, encoding: .utf8) else {
                result = .failure(.decodingFailed)
                return
            }
            
            result = .success(decodedToken)
        }
        
        task.resume()
    }
    
    func requestCharacters<T: Decodable>(
        _ type: T.Type,
        from request: URLRequest,
        completion: @escaping (Result<T, DBError>) -> Void
    ) {
        let task = session.dataTask(with: request) { data, response, error in
            let result: Result<T, DBError>
            
            defer {
                completion(result)
            }
            
            guard error == nil else {
                result = .failure(.unknown)
                return
            }
            
            guard let data else {
                result = .failure(.noData)
                return
            }
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            
            guard statusCode != 401 else {
                result = .failure(.unauthorized)
                return
            }
            
            guard statusCode == 200 else {
                result = .failure(.statusCode(code: statusCode))
                return
            }
            
            guard let decodedObject = try? JSONDecoder().decode(type.self, from: data) else {
                result = .failure(.decodingFailed)
                return
            }
            
            result = .success(decodedObject)
        }
        
        task.resume()
    }
    
    
}
