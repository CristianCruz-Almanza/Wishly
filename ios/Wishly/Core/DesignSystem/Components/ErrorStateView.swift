import SwiftUI

/// Componente Core Reutilizable: Vista para fallos y errores de red.
public struct ErrorStateView: View {
    public let message: String
    public let onRetry: () -> Void
    
    public init(message: String, onRetry: @escaping () -> Void) {
        self.message = message
        self.onRetry = onRetry
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 44))
                .foregroundStyle(.brandDanger)
            
            Text("Ocurrió un error")
                .font(.appSectionTitle)
            
            Text(message)
                .font(.appBody)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            Button(action: onRetry) {
                Label("Reintentar", systemImage: "arrow.clockwise")
                    .fontWeight(.semibold)
            }
            .buttonStyle(.borderedProminent)
            .tint(.brandPrimary)
        }
        .padding(.vertical, 40)
    }
}
