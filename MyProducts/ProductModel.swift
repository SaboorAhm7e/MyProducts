//
//  ProductModel.swift
//  MyProducts
//
//  Created by saboor on 07/12/2025.
//

import Foundation

struct ProductModel  : Codable,Identifiable {
    let id : Int
    let title : String
    let price : Double
    let description : String
    let category : String
    let image : String
}
