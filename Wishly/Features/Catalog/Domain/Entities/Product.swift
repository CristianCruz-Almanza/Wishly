import Foundation

/// Entidad pura de negocio del Feature Catalog.
public struct Product: Identifiable, Hashable, Sendable {
    public let id: Int
    public let title: String
    public let description: String
    public let price: Double
    public let rating: Double
    public let imageUrl: String
    public let category: ProductCategory
    public let stock: Int
    public var isFavorite: Bool
    
    public var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "es_MX")
        return formatter.string(from: NSNumber(value: price)) ?? "$\(price)"
    }
    
    public var isInStock: Bool { stock > 0 }
    
    public init(
        id: Int,
        title: String,
        description: String,
        price: Double,
        rating: Double,
        imageUrl: String,
        category: ProductCategory,
        stock: Int,
        isFavorite: Bool = false
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.price = price
        self.rating = rating
        self.imageUrl = imageUrl
        self.category = category
        self.stock = stock
        self.isFavorite = isFavorite
    }
}

public enum ProductCategory: String, CaseIterable, Hashable, Sendable {
    case all = "Todos"
    case electronics = "Electrónica"
    case fashion = "Moda"
    case home = "Hogar"
    case sports = "Deportes"
    
    public var iconName: String {
        switch self {
        case .all: return "square.grid.2x2.fill"
        case .electronics: return "laptopcomputer"
        case .fashion: return "tshirt.fill"
        case .home: return "house.fill"
        case .sports: return "figure.run"
        }
    }
}
