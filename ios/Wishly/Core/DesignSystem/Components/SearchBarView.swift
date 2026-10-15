import SwiftUI

/// Componente Core Reutilizable: Barra de búsqueda genérica con enlace `@Binding`.
public struct SearchBarView: View {
    @Binding public var text: String
    public var placeholder: String = "Buscar..."
    
    public init(text: Binding<String>, placeholder: String = "Buscar...") {
        self._text = text
        self.placeholder = placeholder
    }
    
    public var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            
            TextField(placeholder, text: $text)
                .textFieldStyle(.plain)
                .font(.appBody)
                .autocorrectionDisabled()
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(10)
        .background(Color.inputBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    @Previewable @State var query = "Buscar"
    SearchBarView(text: $query)
        .padding()
}
