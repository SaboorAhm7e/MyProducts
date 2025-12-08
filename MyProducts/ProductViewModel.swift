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
    
    private let service : NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
    
    func fetchAllProducts() {
        Task {
            do {
                products = try await service.fetchProducts()
            } catch let error as NetworkError {
                print(error.message)
            } catch {
                print("unknown error:\(error.localizedDescription)")
            }
        }
    }
    func fetchDetail(id:Int) async -> ProductModel {
            do {
                return try await  service.fetchProductDetail(id: id)
            } catch let error as NetworkError {
                print(error.message)
                return ProductModel.dummy
            } catch {
                print("unknown error:\(error.localizedDescription)")
                return ProductModel.dummy
            }
    }
}
