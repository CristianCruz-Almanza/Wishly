import Foundation

/// Caso de Uso: Obtener y filtrar productos según búsqueda y categoría.
public struct GetProductsUseCase: Sendable {
    private let repository: ProductRepositoryProtocol
    
    public init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(
        category: ProductCategory = .all,
        searchQuery: String = ""
    ) async throws -> [Product] {
        let allProducts = try await repository.getProducts()
        
        return allProducts.filter { product in
            let matchesCategory = (category == .all) || (product.category == category)
            let matchesSearch = searchQuery.isEmpty ||
                product.title.localizedCaseInsensitiveContains(searchQuery) ||
                product.description.localizedCaseInsensitiveContains(searchQuery)
            
            return matchesCategory && matchesSearch
        }
    }
}
