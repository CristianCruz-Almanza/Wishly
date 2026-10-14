import Foundation

public protocol ProductRemoteDataSourceProtocol: Sendable {
    func fetchProducts() async throws -> [ProductDTO]
}

public final class ProductRemoteDataSource: ProductRemoteDataSourceProtocol, @unchecked Sendable {
    public init() {}
    
    public func fetchProducts() async throws -> [ProductDTO] {
        try await Task.sleep(for: .milliseconds(700))
        
        return [
            ProductDTO(
                id: 1,
                title: "MacBook Pro M3 Max",
                description: "Potencia gráfica sin precedentes y pantalla Liquid Retina XDR de 16 pulgadas.",
                price: 2499.99,
                rating: 4.9,
                image: "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=500&q=80",
                category: "electronics",
                stock: 8
            ),
            ProductDTO(
                id: 2,
                title: "AirPods Max Silver",
                description: "Cancelación activa de ruido pro y audio espacial personalizado con seguimiento dinámico.",
                price: 549.00,
                rating: 4.7,
                image: "https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=500&q=80",
                category: "electronics",
                stock: 15
            ),
            ProductDTO(
                id: 3,
                title: "Chaqueta Cortavientos Running",
                description: "Material ultraligero e impermeable con reflectantes nocturnos de alta visibilidad.",
                price: 89.50,
                rating: 4.5,
                image: "https://images.unsplash.com/photo-1556905055-8f358a7a47b2?w=500&q=80",
                category: "sports",
                stock: 22
            ),
            ProductDTO(
                id: 4,
                title: "Lámpara Minimalista Nórdica",
                description: "Iluminación cálida LED regulable con base de madera natural y control táctil.",
                price: 65.00,
                rating: 4.8,
                image: "https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=500&q=80",
                category: "home",
                stock: 0
            ),
            ProductDTO(
                id: 5,
                title: "Zapatillas Urban Classic",
                description: "Diseño ergonómico con suela amortiguada en piel sintética prémium.",
                price: 119.99,
                rating: 4.6,
                image: "https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?w=500&q=80",
                category: "fashion",
                stock: 12
            ),
            ProductDTO(
                id: 6,
                title: "Smartwatch Deportivo GPS",
                description: "Monitoreo cardíaco 24/7, sumergible hasta 50m y batería de hasta 14 días.",
                price: 199.00,
                rating: 4.4,
                image: "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&q=80",
                category: "sports",
                stock: 5
            )
        ]
    }
}
