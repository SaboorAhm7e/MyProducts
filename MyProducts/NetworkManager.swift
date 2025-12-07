//
//  NetworkManager.swift
//  MyProducts
//
//  Created by saboor on 07/12/2025.
//

import SwiftUI
import Combine

enum NetworkError : Error {
    case invalidURL
    case serverError
    case networkError(error:String)
    
    var message : String {
        switch self {
        case .invalidURL: return "Invalid URL passed"
        case .serverError: return "Server Error"
        case .networkError(let message): return message
        }
    }
}

protocol NetworkService {
    func fetchProducts() async throws -> [ProductModel]
}

final class NetworkManager : NetworkService {
    
    let endpoint = "https://fakestoreapi.com/products"

    func fetchProducts() async throws -> [ProductModel] {
        guard let url = URL(string: endpoint) else { throw NetworkError.invalidURL }
        do {
            let (data,response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse,(200...299).contains(response.statusCode) else {
                throw NetworkError.serverError
            }
            return try JSONDecoder().decode([ProductModel].self, from: data)
            
        } catch let error as DecodingError {
            throw NetworkError.networkError(error: "Decoding Error: \(error.localizedDescription)")
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.networkError(error: error.localizedDescription)
        }
    }
}
