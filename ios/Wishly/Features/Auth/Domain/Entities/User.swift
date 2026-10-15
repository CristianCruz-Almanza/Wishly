import Foundation

/// Entidad pura que representa un usuario autenticado en la aplicación.
/// En Flutter, esto equivale a tu clase modelo inmutable `User`.
struct User: Identifiable, Equatable {
    let id: String
    let email: String
    let displayName: String
    let photoURL: URL?
}
