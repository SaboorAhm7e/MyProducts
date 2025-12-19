//
//  MyProductsApp.swift
//  MyProducts
//
//  Created by saboor on 02/12/2025.
//

import SwiftUI
import SwiftData

@main
struct MyProductsApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .modelContainer(for: [ProductPersistantModel.self])
        }
    }
}
