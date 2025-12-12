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

protocol NetworkService : Sendable {
    func fetchProducts() async throws -> [ProductModel]
    func fetchProductDetail(id:Int) async throws -> ProductModel
    func deleteProduct(id:Int) async throws -> Bool
}

final class NetworkManager : NetworkService {
    
    let endpoint = "https://fakestoreapi.com/products"

    // MARK: - Fetch All Product
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
    // MARK: - Fetch Product Detail
    func fetchProductDetail(id: Int) async throws -> ProductModel {
        
        guard let url = URL(string: endpoint+"/\(id)") else {
            throw NetworkError.invalidURL
        }
        do {
            let (data,response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse,(200...299).contains(response.statusCode) else {
                throw NetworkError.serverError
            }
            return try JSONDecoder().decode(ProductModel.self, from: data)
            
        } catch let error as DecodingError {
            throw NetworkError.networkError(error: error.localizedDescription)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.networkError(error: error.localizedDescription)
        }
    }
    
    func deleteProduct(id: Int) async throws -> Bool {
        guard let url = URL(string: endpoint+"/\(id)") else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        do {
            let (_,response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw NetworkError.serverError
            }
            return true
            
        } catch let error as DecodingError {
            throw NetworkError.networkError(error: error.localizedDescription)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.networkError(error: error.localizedDescription)
        }
        
    }
    
}
class MockNetworkManager : NetworkService {
   
    
    func fetchProducts() async throws -> [ProductModel] {
       try await Task.sleep(nanoseconds: 10_000_00)
        return []
    }
    func fetchProductDetail(id: Int) async throws -> ProductModel {
        try await Task.sleep(nanoseconds: 10_000_00)
        return ProductModel.dummy
    }
    func deleteProduct(id: Int) async throws -> Bool {
        try await Task.sleep(nanoseconds: 10_000_00)
        return true
    }
}
