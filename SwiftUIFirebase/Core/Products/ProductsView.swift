//
//  ProductsView.swift
//  SwiftUIFirebase
//
//  Created by Goncalves Higino on 01/10/23.
//

import SwiftUI


@MainActor
final class ProductViewModel: ObservableObject {
    
    @Published private(set) var products: [Product] = []
    @Published var selectedFilter: FilterOption? = nil
    @Published var selectedCategory: CategoryOption? = nil
    
    func  getAllProduct() async throws {
        self.products = try await ProductsManager.shared.getAllProducts()
    }
    
    func filterSelected(option: FilterOption) async throws {
        
        switch option {
            
            case .noFilter:
                self.products = try await ProductsManager.shared.getAllProducts()
            
            case .priceHigh:
                self.products = try await ProductsManager.shared.getAllProductsSortedByPrice(descending: true)
            
            case .pricelow:
                self.products = try await ProductsManager.shared.getAllProductsSortedByPrice(descending: false)
        }
        
        self.selectedFilter = option
    }
    
    func CategorySelected(option: CategoryOption) async throws {
        
        switch option {
            
        case .noCategory:
            self.products = try await ProductsManager.shared.getAllProducts()
            
        case .smartphones, .laptops, .fragrances:
            self.products = try await ProductsManager.shared.getAllProductsForCategory(category: option.rawValue)
            
        }
        
        self.selectedCategory = option
    }
    
    enum FilterOption: String, CaseIterable {
        case noFilter
        case priceHigh
        case pricelow
    }
    
    enum CategoryOption: String, CaseIterable {
        case noCategory
        case smartphones
        case laptops
        case fragrances
    }

}

struct ProductsView: View {
    @StateObject private var viewModel = ProductViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.products) { product in
               ProductCellView(product: product)
            }
        }
        .navigationTitle("Products")
        .toolbar(content: {
            
            ToolbarItem(placement: .navigationBarLeading) {
                Menu("Filter: \(viewModel.selectedFilter?.rawValue ?? "NONE")") {
                    ForEach(ProductViewModel.FilterOption.allCases, id: \.self) { option in
                        Button(option.rawValue) {
                            Task {
                                try await viewModel.filterSelected(option: option)
                            }
                        }
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu("Category: \(viewModel.selectedCategory?.rawValue ?? "NONE")") {
                    ForEach(ProductViewModel.CategoryOption.allCases, id: \.self) { option in
                        Button(option.rawValue) {
                            Task {
                                try await viewModel.CategorySelected(option: option)
                            }
                        }
                    }
                }
            }
        })
        .task {
            try? await viewModel.getAllProduct()
        }
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProductsView()
        }
    }
}
