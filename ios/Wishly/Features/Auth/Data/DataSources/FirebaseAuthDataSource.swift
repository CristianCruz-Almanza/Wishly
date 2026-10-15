import Foundation
import UIKit
import FirebaseAuth
import GoogleSignIn

/// Protocolo para el Data Source de autenticación.
/// En Flutter, esto equivale a una interfaz abstracta para tu `RemoteDataSource`.
protocol FirebaseAuthDataSourceProtocol {
    func signInWithGoogle() async throws -> User
    func signOut() throws
    func getCurrentUser() -> User?
}

/// Implementación concreta que habla directamente con los SDKs de Firebase Auth y GoogleSignIn.
final class FirebaseAuthDataSource: FirebaseAuthDataSourceProtocol {
    
    @MainActor
    func signInWithGoogle() async throws -> User {
        // En iOS necesitamos el UIViewController visible para presentar el modal de Google Sign-In.
        guard let windowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive }),
              let rootViewController = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
            throw NSError(
                domain: "AuthError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "No se encontró el ViewController principal para presentar Google Sign-In."]
            )
        }
        
        // 1. Solicitamos autenticación a Google SignIn
        let signInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
        
        guard let idToken = signInResult.user.idToken?.tokenString else {
            throw NSError(
                domain: "AuthError",
                code: -2,
                userInfo: [NSLocalizedDescriptionKey: "Google Sign-In no retornó un idToken válido."]
            )
        }
        
        let accessToken = signInResult.user.accessToken.tokenString
        
        // 2. Creamos la credencial de Firebase con los tokens de Google
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: accessToken
        )
        
        // 3. Autenticamos contra Firebase Auth
        let authResult = try await Auth.auth().signIn(with: credential)
        let firebaseUser = authResult.user
        
        return User(
            id: firebaseUser.uid,
            email: firebaseUser.email ?? "",
            displayName: firebaseUser.displayName ?? "",
            photoURL: firebaseUser.photoURL
        )
    }
    
    func signOut() throws {
        GIDSignIn.sharedInstance.signOut()
        try Auth.auth().signOut()
    }
    
    func getCurrentUser() -> User? {
        guard let firebaseUser = Auth.auth().currentUser else { return nil }
        return User(
            id: firebaseUser.uid,
            email: firebaseUser.email ?? "",
            displayName: firebaseUser.displayName ?? "",
            photoURL: firebaseUser.photoURL
        )
    }
}
