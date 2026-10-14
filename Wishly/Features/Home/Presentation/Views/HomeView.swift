import SwiftUI

struct HomeView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack(spacing: 20) {
            Text("🏠 Bienvenido al Home")
                .font(.title)
                .fontWeight(.medium)
            
            Button(action: {
                // Equivalente a: Navigator.popUntil(context, (route) => route.isFirst)
                router.popToRoot()
            }) {
                Text("Cerrar Sesión")
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(10)
            }
            .padding(.horizontal, 40)
        }
        .navigationTitle("Inicio")
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(Router())
    }
}
