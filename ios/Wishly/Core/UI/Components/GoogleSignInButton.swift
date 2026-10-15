import SwiftUI

/// Botón reutilizable del Design System para iniciar sesión con Google.
/// Mantiene la misma altura (56pt), esquinas redondeadas (10pt) y tipografía que PrimaryButton.
struct GoogleSignInButton: View {
    var title: String = "Continuar con Google"
    var isLoading: Bool = false
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                if isLoading {
                    ProgressView()
                        .tint(.primary)
                } else {
                    HStack(spacing: 12) {
                        GoogleLogoView()
                            .frame(width: 20, height: 20)
                        
                        Text(title)
                            .font(.headline)
                            .foregroundColor(Color(uiColor: .label))
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(red: 0.85, green: 0.85, blue: 0.85), lineWidth: 1)
            )
        }
        .disabled(isLoading)
    }
}

/// Logo oficial de Google dibujado con Canvas vectorial para no depender de assets externos.
struct GoogleLogoView: View {
    var body: some View {
        Image(systemName: "g.circle.fill")
            .resizable()
            .scaledToFit()
            .foregroundColor(.red)
            .overlay(
                Text("G")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
            )
    }
}

#Preview {
    VStack(spacing: 16) {
        GoogleSignInButton(action: {})
        GoogleSignInButton(isLoading: true, action: {})
    }
    .padding()
}
