//
//  ProductModel.swift
//  MyProducts
//
//  Created by saboor on 07/12/2025.
//

import Foundation

struct ProductModel  : Codable,Identifiable,Equatable {
    let id : Int
    let title : String
    let price : Double
    let description : String
    let category : String
    let image : String
}
extension ProductModel {
    static let dummy = ProductModel(id: 1, title: "Some Title", price: 0, description: "Some Description", category: "category", image: "")
}
