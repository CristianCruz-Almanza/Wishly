---
trigger: always_on
description: Reglas generales del monorepo Wishly (iOS + Android). Aplican siempre.
---

# 🎁 Wishly — Reglas generales del proyecto

Wishly es una plataforma de **wishlist universal**, **rastreo de precios** y **regalos sociales**.
Monorepo con dos apps **nativas** que comparten backend (Firebase), modelo de datos y Design System:

| Plataforma | Carpeta    | Stack                                  | Identificador          |
|------------|------------|----------------------------------------|------------------------|
| iOS        | `ios/`     | SwiftUI · Swift Concurrency            | `com.cristian.wishly`  |
| Android    | `android/` | Jetpack Compose · Kotlin Coroutines    | `com.cristian.wishly`  |

Documentación del proyecto: `docs/` (arquitectura, setup, Firebase). Mantenerla actualizada cuando cambie algo relevante.

## 🎯 Principios (obligatorios)
1. **Clean Architecture + MVVM por Features** (`Presentation / Domain / Data`) en ambas plataformas.
2. **DRY — cero código repetido.** Todo componente UI usado más de una vez se extrae al Design System (`Core/UI` en iOS, `core/ui` en Android).
3. **SOLID** e **inyección de dependencias por constructor**. Domain no depende de frameworks (ni Firebase, ni SwiftUI, ni Compose).
4. **Paridad 1:1 iOS ↔ Android**: misma estructura de carpetas, mismos nombres de tipos (`LoginView`, `AuthRepository`, `SignInWithGoogleUseCase`…), mismo comportamiento.
5. **Paridad visual (Design System estricto)**: no usar estilos por defecto del SO directamente en pantallas; usar wrappers propios (colores, tipografías, paddings, radios) para que ambas apps se vean idénticas.

## 👨‍🏫 Flujo de trabajo del agente
- **Didáctico**: el usuario viene de **Flutter**. Explicar los conceptos nuevos con analogías Flutter (Widget, ChangeNotifier/Bloc, abstract class, Future/Stream…).
- **Flujo paralelo**: cada feature se implementa en **iOS y Android en el mismo turno**. Escribir los archivos directamente; **no pegar el código completo en el chat**, solo explicar las diferencias clave entre plataformas.
- Verificar que compila (Android: `./gradlew :app:compileDebugKotlin` desde `android/`; iOS: `xcodebuild` sobre `ios/Wishly.xcodeproj`) antes de dar algo por terminado.
- Commits pequeños y descriptivos.

## 🔐 Secretos
- **Nunca** subir `GoogleService-Info.plist`, `google-services.json`, `.env`, `local.properties` ni keystores. Están en `.gitignore`.
- Si falta un archivo de configuración, indicar al usuario de dónde descargarlo (ver `docs/firebase-setup.md`).
