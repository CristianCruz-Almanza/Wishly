import Foundation
import Observation

public enum ProductUiState: Equatable {
    case initial
    case loading
    case success([Product])
    case empty
    case error(String)
}

@Observable
@MainActor
public final class ProductListViewModel {
    public private(set) var state: ProductUiState = .initial
    
    public var selectedCategory: ProductCategory = .all {
        didSet { Task { await loadProducts() } }
    }
    
    public var searchQuery: String = "" {
        didSet { Task { await loadProducts() } }
    }
    
    private let getProductsUseCase: GetProductsUseCase
    private let toggleFavoriteUseCase: ToggleFavoriteUseCase
    
    public init(
        getProductsUseCase: GetProductsUseCase,
        toggleFavoriteUseCase: ToggleFavoriteUseCase
    ) {
        self.getProductsUseCase = getProductsUseCase
        self.toggleFavoriteUseCase = toggleFavoriteUseCase
    }
    
    public func loadProducts() async {
        if case .initial = state {
            state = .loading
        }
        
        do {
            let products = try await getProductsUseCase.execute(
                category: selectedCategory,
                searchQuery: searchQuery
            )
            state = products.isEmpty ? .empty : .success(products)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
    
    public func toggleFavorite(for product: Product) async {
        do {
            let updated = try await toggleFavoriteUseCase.execute(productId: product.id)
            if case .success(let currentProducts) = state {
                let updatedList = currentProducts.map { p in
                    p.id == updated.id ? updated : p
                }
                state = .success(updatedList)
            }
        } catch {
            print("Error al cambiar favorito: \(error.localizedDescription)")
        }
    }
}
