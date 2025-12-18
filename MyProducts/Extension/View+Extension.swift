//
//  View+Extension.swift
//  MyProducts
//
//  Created by saboor on 18/12/2025.
//

import SwiftUI

extension View {
    func searching(tabCase:Binding<TabCase>,txt:Binding<String>) -> some View {
        modifier(Searching(tabCase: tabCase, searchText: txt))
    }
}
