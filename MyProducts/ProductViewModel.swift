//
//  ProductViewModel.swift
//  MyProducts
//
//  Created by saboor on 07/12/2025.
//

import SwiftUI
import Combine

//@MainActor
final class ProductViewModel : ObservableObject {
    @Published var products : [ProductModel] = []
    @Published var errorMessage : String = ""
    
    private let service : NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
    
    func fetchAllProducts() {
        Task {
            do {
                products = try await service.fetchProducts()
            } catch let error as NetworkError {
                errorMessage = error.message
            } catch {
                errorMessage = "unknown error:\(error.localizedDescription)"
            }
        }
    }
    func fetchDetail(id:Int) async -> ProductModel {
            do {
                return try await  service.fetchProductDetail(id: id)
            } catch let error as NetworkError {
                errorMessage = error.message
                return ProductModel.dummy
            } catch {
                errorMessage = "unknown error:\(error.localizedDescription)"
                return ProductModel.dummy
            }
    }
    func deleteProduct(id:Int) async  {
        do {
            let _ = try await service.deleteProduct(id: id)
            errorMessage = "Successfuly delete product"
        } catch let error as NetworkError {
            errorMessage = error.message
        } catch {
            errorMessage = "unknown error:\(error.localizedDescription)"
        }
    }
    func addProduct(product:ProductModel) async {
            do {
                let _ = try await service.addProduct(product: product)
                errorMessage = "Successfuly add product"
            } catch let error as NetworkError {
                errorMessage = error.message
            } catch {
                errorMessage = "unknown error: \(error.localizedDescription)"
            }
    }
}
