import Foundation

public struct ProductDTO: Codable, Sendable {
    public let id: Int
    public let title: String
    public let description: String
    public let price: Double
    public let rating: Double
    public let image: String
    public let category: String
    public let stock: Int
    
    public func toDomain(isFavorite: Bool = false) -> Product {
        let domainCategory: ProductCategory
        switch category.lowercased() {
        case "electronics", "electrónica": domainCategory = .electronics
        case "fashion", "moda": domainCategory = .fashion
        case "home", "hogar": domainCategory = .home
        case "sports", "deportes": domainCategory = .sports
        default: domainCategory = .electronics
        }
        
        return Product(
            id: id,
            title: title,
            description: description,
            price: price,
            rating: rating,
            imageUrl: image,
            category: domainCategory,
            stock: stock,
            isFavorite: isFavorite
        )
    }
}
