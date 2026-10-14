import SwiftUI

/// Sistema centralizado de colores de la aplicación (Design Tokens).
///
/// - Nota para desarrolladores Flutter:
///   Equivale a tu `ColorScheme` o `AppColors` estático en Dart.
///   Al extender tanto `Color` como `ShapeStyle`, puedes usar la sintaxis abreviada
///   `.foregroundStyle(.brandPrimary)` y `.background(Color.cardBackground)`.
public extension Color {
    // MARK: - Colores de Marca (Brand Colors)
    static let brandPrimary = Color.blue
    static let brandAccent = Color(red: 1.0, green: 0.58, blue: 0.0)
    static let brandSuccess = Color.green
    static let brandDanger = Color.red
    
    // MARK: - Colores Semánticos de Fondo
    static let appBackground = Color(uiColor: .systemGroupedBackground)
    static let cardBackground = Color(uiColor: .secondarySystemGroupedBackground)
    static let inputBackground = Color(uiColor: .tertiarySystemGroupedBackground)
}

public extension ShapeStyle where Self == Color {
    static var brandPrimary: Color { .brandPrimary }
    static var brandAccent: Color { .brandAccent }
    static var brandSuccess: Color { .brandSuccess }
    static var brandDanger: Color { .brandDanger }
    static var appBackground: Color { .appBackground }
    static var cardBackground: Color { .cardBackground }
    static var inputBackground: Color { .inputBackground }
}
