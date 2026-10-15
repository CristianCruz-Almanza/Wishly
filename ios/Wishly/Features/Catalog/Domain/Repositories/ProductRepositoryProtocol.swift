import Foundation

/// Contrato del repositorio para el Feature Catalog.
public protocol ProductRepositoryProtocol: Sendable {
    func getProducts() async throws -> [Product]
    func getProduct(byId id: Int) async throws -> Product?
    func toggleFavorite(productId: Int) async throws -> Product
}
