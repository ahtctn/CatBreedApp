//
//  APIManager.swift
//  CatAPI
//
//  Created by Ahmet Ali ÇETİN on 28.03.2023.
//

import UIKit

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case decodingError( _ error: Error)
}

typealias Handler = (Result <[BreedModel], NetworkError>) -> Void

class APIManager {
    static let shared = APIManager()
    private init() {
        
    }
    
    func fetchBreeds(completion: @escaping Handler) {
        guard let url = URL(string: Constants.API.url) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let breeds = try decoder.decode([BreedModel].self, from: data)
                completion(.success(breeds))
            } catch {
                print(error.localizedDescription)
                print("aha bura girdi")
                completion(.failure(NetworkError.decodingError(error)))
            }
            
        } .resume()
    }
}
