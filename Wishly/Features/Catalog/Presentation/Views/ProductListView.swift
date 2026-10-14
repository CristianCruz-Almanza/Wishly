import SwiftUI

public struct ProductListView: View {
    @Environment(\.appTheme) private var theme
    @State private var viewModel: ProductListViewModel
    
    private let columns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]
    
    public init(viewModel: ProductListViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 18) {
                    // Barra de Búsqueda Core
                    SearchBarView(text: $viewModel.searchQuery, placeholder: "Buscar en el catálogo...")
                        .padding(.horizontal)
                    
                    // Selector de Categorías
                    categorySelectorView
                    
                    // Estado de UI
                    switch viewModel.state {
                    case .initial, .loading:
                        ProgressView("Cargando productos...")
                            .padding(.top, 40)
                        
                    case .success(let products):
                        LazyVGrid(columns: columns, spacing: 14) {
                            ForEach(products) { product in
                                NavigationLink(value: product) {
                                    ProductCardView(
                                        product: product,
                                        onFavoriteToggle: {
                                            Task { await viewModel.toggleFavorite(for: product) }
                                        }
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal)
                        
                    case .empty:
                        EmptyStateView()
                            .padding(.top, 20)
                        
                    case .error(let message):
                        ErrorStateView(message: message) {
                            Task { await viewModel.loadProducts() }
                        }
                        .padding(.top, 20)
                    }
                }
                .padding(.vertical)
            }
            .background(Color.appBackground)
            .navigationTitle("Explorar")
            .navigationDestination(for: Product.self) { product in
                ProductDetailView(
                    product: product,
                    onFavoriteToggle: {
                        Task { await viewModel.toggleFavorite(for: product) }
                    }
                )
            }
            .task { await viewModel.loadProducts() }
            .refreshable { await viewModel.loadProducts() }
        }
    }
    
    private var categorySelectorView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(ProductCategory.allCases, id: \.self) { category in
                    let isSelected = viewModel.selectedCategory == category
                    
                    Button(action: { viewModel.selectedCategory = category }) {
                        HStack(spacing: 6) {
                            Image(systemName: category.iconName)
                            Text(category.rawValue)
                        }
                        .font(.appBadge)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(isSelected ? theme.primaryColor : Color.cardBackground)
                        .foregroundStyle(isSelected ? Color.white : Color.primary)
                        .clipShape(Capsule())
                        .shadow(color: .black.opacity(isSelected ? 0.15 : 0.03), radius: 4, x: 0, y: 2)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    let repo = ProductRepository()
    let getUseCase = GetProductsUseCase(repository: repo)
    let toggleUseCase = ToggleFavoriteUseCase(repository: repo)
    let vm = ProductListViewModel(getProductsUseCase: getUseCase, toggleFavoriteUseCase: toggleUseCase)
    
    ProductListView(viewModel: vm)
        .appTheme(AppTheme(primaryColor: .indigo))
}
