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
    let description : String
    let category : String
    let image : String
}
extension ProductModel {
    static let dummy = ProductModel(id: 1, title: "title", price: 0, description: "description", category: "none", image: "")
}

@Model
class ProductPersistantModel {
    @Attribute(.unique) var id : Int
    var title : String
    var price : Double
    var desc : String
    var category : String
    var image : String
    
    var quantity : Int = 1
    
   @Transient var calculatedPrice : String {
        return String(Int(price) * quantity)
    }
    
    init(id: Int, title: String, price: Double, desc: String, category: String, image: String) {
        self.id = id
        self.title = title
        self.price = price
        self.desc = desc
        self.category = category
        self.image = image
    }
}
