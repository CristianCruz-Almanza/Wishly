import SwiftUI

/// Sistema centralizado de tipografías y estilos de texto.
///
/// - Nota para desarrolladores Flutter:
///   Equivale a `TextTheme` en `ThemeData` (ej: `Theme.of(context).textTheme.headlineMedium`).
public extension Font {
    
    /// Título destacado para encabezados principales
    static let appLargeTitle = Font.system(size: 32, weight: .bold, design: .rounded)
    
    /// Título para secciones y tarjetas principales
    static let appSectionTitle = Font.system(size: 20, weight: .bold, design: .default)
    
    /// Subtítulo con peso medio
    static let appSubtitle = Font.system(size: 16, weight: .medium, design: .default)
    
    /// Cuerpo de texto para descripciones y contenido
    static let appBody = Font.system(size: 14, weight: .regular, design: .default)
    
    /// Texto pequeño para badges y etiquetas
    static let appBadge = Font.system(size: 12, weight: .semibold, design: .rounded)
    
    /// Precios y números destacados
    static let appPrice = Font.system(size: 18, weight: .heavy, design: .rounded)
}
