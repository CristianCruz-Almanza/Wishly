import Foundation

public final class ProductRepository: ProductRepositoryProtocol, @unchecked Sendable {
    private let remoteDataSource: ProductRemoteDataSourceProtocol
    private var cachedProducts: [Product] = []
    private var favoriteIds: Set<Int> = []
    
    public init(remoteDataSource: ProductRemoteDataSourceProtocol = ProductRemoteDataSource()) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func getProducts() async throws -> [Product] {
        if cachedProducts.isEmpty {
            let dtos = try await remoteDataSource.fetchProducts()
            cachedProducts = dtos.map { dto in
                dto.toDomain(isFavorite: favoriteIds.contains(dto.id))
            }
        }
        return cachedProducts
    }
    
    public func getProduct(byId id: Int) async throws -> Product? {
        let products = try await getProducts()
        return products.first { $0.id == id }
    }
    
    public func toggleFavorite(productId: Int) async throws -> Product {
        if favoriteIds.contains(productId) {
            favoriteIds.remove(productId)
        } else {
            favoriteIds.insert(productId)
        }
        
        guard let index = cachedProducts.firstIndex(where: { $0.id == productId }) else {
            throw NetworkError.notFound
        }
        
        cachedProducts[index].isFavorite = favoriteIds.contains(productId)
        return cachedProducts[index]
    }
}
