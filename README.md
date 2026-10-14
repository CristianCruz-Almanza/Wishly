# 🎁 Wishly (iOS)

> Todo lo que quieres, en un solo lugar. Al mejor precio. Y que tus amigos sepan qué regalarte.

Wishly es una plataforma de **wishlist universal**, **rastreo de precios** y **regalos sociales** (listas compartidas, eventos, apartar regalos y regalos en grupo).

Este repositorio contiene la app **nativa de iOS** (SwiftUI). Existe una app hermana nativa en **Android (Kotlin)** que comparte el mismo backend de Firebase, modelo de datos y Design System.

## Stack
- SwiftUI · Swift Concurrency (`async/await`)
- Clean Architecture por Features (Presentation / Domain / Data)
- Firebase: Auth (Google, Apple), Firestore, Cloud Functions, Cloud Messaging, Storage, Crashlytics

## Estructura
```
Wishly/
├── Core/        Design System, UI components, Network, Navigation, State
└── Features/    Auth, Catalog (→ Wishlist), Home, Splash
```

## Requisitos
- Xcode 26+
- iOS 26.2+

## Configuración local
1. Clonar el repositorio.
2. Descargar `GoogleService-Info.plist` desde la consola de Firebase (proyecto **Wishly**, app iOS `com.cristian.wishly`).
3. Colocarlo en `Wishly/GoogleService-Info.plist`. El archivo está en `.gitignore` y **no se sube** al repositorio.
4. Abrir `Wishly.xcodeproj` y ejecutar.

## Reglas del proyecto
Ver [PROJECT_RULES.md](PROJECT_RULES.md).
