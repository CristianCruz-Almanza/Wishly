import SwiftUI

/// Componente específico del Feature Catalog: Tarjeta de Producto con Design Tokens.
public struct ProductCardView: View {
    @Environment(\.appTheme) private var theme
    
    public let product: Product
    public let onFavoriteToggle: () -> Void
    
    public init(product: Product, onFavoriteToggle: @escaping () -> Void) {
        self.product = product
        self.onFavoriteToggle = onFavoriteToggle
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Imagen con botón flotante
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: product.imageUrl)) { phase in
                    switch phase {
                    case .empty:
                        ZStack {
                            Color.inputBackground
                            ProgressView()
                        }
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        ZStack {
                            Color.inputBackground
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundStyle(.secondary)
                        }
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(height: 140)
                .clipShape(RoundedRectangle(cornerRadius: theme.cardCornerRadius - 4))
                
                Button(action: onFavoriteToggle) {
                    Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                        .font(.body)
                        .foregroundStyle(product.isFavorite ? .brandDanger : .primary)
                        .padding(8)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
                }
                .padding(8)
                .buttonStyle(.plain)
            }
            
            // Badges
            HStack {
                if product.isInStock {
                    StatusBadgeView(text: "En Stock", color: .brandSuccess)
                } else {
                    StatusBadgeView(text: "Agotado", color: .brandDanger)
                }
                
                Spacer()
                
                HStack(spacing: 2) {
                    Image(systemName: "star.fill")
                        .font(.caption2)
                        .foregroundStyle(.yellow)
                    Text(String(format: "%.1f", product.rating))
                        .font(.appBadge)
                }
            }
            
            // Título
            Text(product.title)
                .font(.appSubtitle)
                .lineLimit(1)
                .foregroundStyle(.primary)
            
            // Descripción
            Text(product.description)
                .font(.appBody)
                .foregroundStyle(.secondary)
                .lineLimit(2)
            
            // Precio
            Text(product.formattedPrice)
                .font(.appPrice)
                .foregroundStyle(theme.primaryColor)
        }
        .padding(12)
        .background(Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: theme.cardCornerRadius))
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
    }
}
