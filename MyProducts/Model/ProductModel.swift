//
//  ProductModel.swift
//  MyProducts
//
//  Created by saboor on 07/12/2025.
//

import Foundation
import SwiftData

struct ProductModel  : Codable,Identifiable,Equatable {
    let id : Int
    let title : String
    let price : Double
    let desc : String
    let category : String
    let image : String
}
extension ProductModel {
    static let dummy = ProductModel(id: 1, title: "", price: 0, desc: "", category: "", image: "")
}

@Model
class ProductPersistantModel {
    var id : Int
    var title : String
    var price : Double
    var desc : String
    var category : String
    var image : String
    
    init(id: Int, title: String, price: Double, desc: String, category: String, image: String) {
        self.id = id
        self.title = title
        self.price = price
        self.desc = desc
        self.category = category
        self.image = image
    }
}
