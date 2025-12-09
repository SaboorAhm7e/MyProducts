//
//  SortManager.swift
//  MyProducts
//
//  Created by saboor on 09/12/2025.
//

import Foundation

struct SortManager {
    static func sortInAscendingOrder(_ arr:[ProductModel]) -> [ProductModel] {
        return arr.sorted {$0.title < $1.title }
    }
    static func sortInDescendingOrder(_ arr:[ProductModel]) -> [ProductModel] {
         return arr.sorted {$0.title > $1.title}
    }
    static func sortInHightToLowPrice(_ arr:[ProductModel]) -> [ProductModel]{
        return arr.sorted { $0.price > $1.price }
    }
    static func sortInLowToHighPrice(_ arr:[ProductModel]) -> [ProductModel] {
        return arr.sorted { $0.price < $1.price }
    }
}
