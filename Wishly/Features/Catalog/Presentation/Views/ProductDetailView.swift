import SwiftUI

public struct ProductDetailView: View {
    @Environment(\.appTheme) private var theme
    
    public let product: Product
    public let onFavoriteToggle: () -> Void
    
    public init(product: Product, onFavoriteToggle: @escaping () -> Void) {
        self.product = product
        self.onFavoriteToggle = onFavoriteToggle
    }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Imagen
                AsyncImage(url: URL(string: product.imageUrl)) { phase in
                    if let image = phase.image {
                        image.resizable().scaledToFill()
                    } else {
                        ZStack {
                            Color.inputBackground
                            ProgressView()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 280)
                .clipShape(RoundedRectangle(cornerRadius: theme.cardCornerRadius + 4))
                
                // Badges y Rating
                HStack {
                    StatusBadgeView(
                        text: product.category.rawValue,
                        iconName: product.category.iconName,
                        color: theme.primaryColor
                    )
                    
                    if product.isInStock {
                        StatusBadgeView(text: "En Stock (\(product.stock))", iconName: "checkmark.circle.fill", color: .brandSuccess)
                    } else {
                        StatusBadgeView(text: "Agotado", iconName: "xmark.circle.fill", color: .brandDanger)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill").foregroundStyle(.yellow)
                        Text(String(format: "%.1f", product.rating)).font(.appBadge)
                    }
                }
                
                // Título y Precio
                VStack(alignment: .leading, spacing: 8) {
                    Text(product.title)
                        .font(.appLargeTitle)
                    
                    Text(product.formattedPrice)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(theme.primaryColor)
                }
                
                Divider()
                
                // Descripción
                VStack(alignment: .leading, spacing: 8) {
                    Text("Descripción").font(.appSectionTitle)
                    Text(product.description).font(.appBody).foregroundStyle(.secondary).lineSpacing(4)
                }
                
                Spacer(minLength: 20)
                
                // Botón de Compra
                Button(action: {}) {
                    HStack {
                        Image(systemName: "cart.fill")
                        Text("Agregar al Carrito")
                    }
                    .font(.appSubtitle)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                }
                .buttonStyle(.borderedProminent)
                .tint(theme.primaryColor)
                .disabled(!product.isInStock)
            }
            .padding()
        }
        .background(Color.appBackground)
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: onFavoriteToggle) {
                    Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(product.isFavorite ? .brandDanger : .primary)
                }
            }
        }
    }
}
