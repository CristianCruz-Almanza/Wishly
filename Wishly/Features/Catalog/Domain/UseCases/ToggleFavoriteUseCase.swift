import Foundation

/// Caso de Uso: Alternar estado de favorito en un producto.
public struct ToggleFavoriteUseCase: Sendable {
    private let repository: ProductRepositoryProtocol
    
    public init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(productId: Int) async throws -> Product {
        try await repository.toggleFavorite(productId: productId)
    }
}
