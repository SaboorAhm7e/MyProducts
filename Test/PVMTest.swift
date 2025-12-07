//
//  PVMTest.swift
//  Test
//
//  Created by saboor on 07/12/2025.
//

import Testing

@testable import MyProducts

struct PVMTest  {

    var viewModel : ProductViewModel?
    
    init() {
        viewModel = ProductViewModel(service: MockNetworkManager())
    }
    
    @Test("Test View Model") func isViewModelValid()  {
        viewModel?.fetchAllProducts()
        #expect(viewModel?.products.isEmpty == true,"product must be empty")
    }
    
    

}
