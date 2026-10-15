import SwiftUI

/// Componente Core Reutilizable: Chip o Badge de estado.
public struct StatusBadgeView: View {
    public let text: String
    public let iconName: String?
    public let color: Color
    
    public init(text: String, iconName: String? = nil, color: Color = .brandPrimary) {
        self.text = text
        self.iconName = iconName
        self.color = color
    }
    
    public var body: some View {
        HStack(spacing: 4) {
            if let icon = iconName {
                Image(systemName: icon)
                    .font(.caption2)
                    .fontWeight(.bold)
            }
            Text(text)
                .font(.appBadge)
        }
        .foregroundStyle(color)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(color.opacity(0.12))
        .clipShape(Capsule())
    }
}

#Preview {
    StatusBadgeView(text: "En Stock", iconName: "checkmark.circle.fill", color: .brandSuccess)
        .padding()
}
