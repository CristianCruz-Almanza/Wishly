import SwiftUI

/// Configuración del Tema global de la aplicación.
///
/// - Nota para desarrolladores Flutter:
///   Equivale a la clase `ThemeData` que inyectas en el `MaterialApp`.
public struct AppTheme: Sendable {
    public let primaryColor: Color
    public let accentColor: Color
    public let cardCornerRadius: CGFloat
    public let defaultPadding: CGFloat
    
    public init(
        primaryColor: Color = .brandPrimary,
        accentColor: Color = .brandAccent,
        cardCornerRadius: CGFloat = 16,
        defaultPadding: CGFloat = 16
    ) {
        self.primaryColor = primaryColor
        self.accentColor = accentColor
        self.cardCornerRadius = cardCornerRadius
        self.defaultPadding = defaultPadding
    }
}

// MARK: - Inyección con @Environment (Equivalente a Theme.of(context))

private struct AppThemeKey: EnvironmentKey {
    static let defaultValue = AppTheme()
}

public extension EnvironmentValues {
    /// Permite acceder al tema de la app desde cualquier vista con `@Environment(\.appTheme) private var theme`.
    var appTheme: AppTheme {
        get { self[AppThemeKey.self] }
        set { self[AppThemeKey.self] = newValue }
    }
}

public extension View {
    /// Modificador para aplicar un tema personalizado al árbol de vistas.
    func appTheme(_ theme: AppTheme) -> some View {
        environment(\.appTheme, theme)
    }
}
