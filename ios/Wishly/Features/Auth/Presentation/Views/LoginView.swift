import SwiftUI

struct LoginView: View {
    @EnvironmentObject var router: Router
    @StateObject private var viewModel = LoginViewModel()
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Iniciar Sesión")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            AppTextField(placeholder: "Correo electrónico", text: $email)
            
            AppTextField(placeholder: "Contraseña", text: $password, isSecure: true)
            
            Spacer().frame(height: 10)
            
            PrimaryButton(title: "Entrar") {
                router.navigate(to: .home)
            }
            
            HStack {
                Rectangle()
                    .fill(Color(red: 0.88, green: 0.88, blue: 0.88))
                    .frame(height: 1)
                Text("o continúa con")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 8)
                Rectangle()
                    .fill(Color(red: 0.88, green: 0.88, blue: 0.88))
                    .frame(height: 1)
            }
            .padding(.vertical, 8)
            
            GoogleSignInButton(isLoading: viewModel.state.isLoading) {
                Task {
                    await viewModel.signInWithGoogle()
                }
            }
            
            if let error = viewModel.state.errorMessage {
                Text(error)
                    .font(.footnote)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.top, 4)
            }
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.top, 40)
        .navigationBarBackButtonHidden(true)
        .onChange(of: viewModel.state.isAuthenticated) { isAuthenticated in
            if isAuthenticated {
                router.navigate(to: .home)
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(Router())
}
