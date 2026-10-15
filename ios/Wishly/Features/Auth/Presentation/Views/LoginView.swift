import SwiftUI

struct LoginView: View {
    @EnvironmentObject var router: Router
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
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.top, 40)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LoginView()
        .environmentObject(Router())
}
