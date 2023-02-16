//
//  APIManager.swift
//  MVVMPattern-eCart
//
//  Created by Mekala Vamsi Krishna on 14/02/23.
//

import UIKit

// singlton class :- It can access by both by creating object and as well as shared instance outside the class
// Singlton class :- Only can access by shared instance outside the class
// final keyword :- final class cannot be inherites by the other classes

//typealias Handler = (Result<[Product], DataError>) -> Void
typealias Handler<T> = (Result<T, DataError>) -> Void

enum DataError: Error {
    case invalidResponse
    case invalidURl
    case invalidData
    case network(Error?)
}

final class APIManager {
    
    static let shared = APIManager()
    private init() {} // Due to this private initializer the class becomes 'S'inglton class
    
    func request<T: Codable>(
        modelType: T.Type,
        type: EndPointType,
        completion: @escaping Handler<T>
    ) {
        guard let url = URL(string: Constants.API.productURL) else {
            completion(.failure(.invalidURl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.method.rawValue
        
        if let parameters = type.body {
            request.httpBody = try? JSONEncoder().encode(parameters)
        }
        
        request.allHTTPHeaderFields = type.headers
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
//            guard let data = data, error == nil else { return }
            guard let data, error == nil else { // New style
                completion(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let products = try JSONDecoder().decode(modelType , from: data)
                completion(.success(products))
            } catch {
                completion(.failure(.network(error)))
            }
            
        }.resume()
    }
    
    static var commonHeaders: [String: String] {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    /*
    func fetchProducts(completion: @escaping Handler) {
        
        guard let url = URL(string: Constants.API.productURL) else {
            completion(.failure(.invalidURl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
//            guard let data = data, error == nil else { return }
            guard let data, error == nil else { // New style
                completion(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
            } catch {
                completion(.failure(.network(error)))
            }
            
        }.resume()
        
    }
     */
    
}
