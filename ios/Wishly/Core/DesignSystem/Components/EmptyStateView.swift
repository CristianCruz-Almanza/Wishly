import SwiftUI

/// Componente Core Reutilizable: Vista para estados sin datos.
public struct EmptyStateView: View {
    public let iconName: String
    public let title: String
    public let message: String
    
    public init(
        iconName: String = "tray",
        title: String = "No hay elementos",
        message: String = "No se encontraron resultados para los filtros seleccionados."
    ) {
        self.iconName = iconName
        self.title = title
        self.message = message
    }
    
    public var body: some View {
        VStack(spacing: 12) {
            Image(systemName: iconName)
                .font(.system(size: 48))
                .foregroundStyle(.secondary)
            
            Text(title)
                .font(.appSectionTitle)
            
            Text(message)
                .font(.appBody)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .padding(.vertical, 40)
    }
}
