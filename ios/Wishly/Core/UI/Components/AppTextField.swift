import SwiftUI

struct AppTextField: View {
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .padding()
        .frame(height: 56)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)
    }
}
