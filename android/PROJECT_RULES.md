# 📱 Reglas del Proyecto: Clean Architecture en Kotlin (Android)

Este documento es el espejo de las reglas de Swift, adaptado para Android. Mantendremos **paridad 1:1** con el proyecto de iOS.

## 🎯 Objetivo General
Mantener una arquitectura **SÓLIDA, escalable y testeable**, utilizando **Clean Architecture** y **MVVM**. Regla de oro: **Cero código repetido (DRY)**.

---

## 🏗️ Estructura: Clean Architecture + MVVM

Agrupado por **Features**.

### 1. Presentation (UI)
*   **Views:** Construidas con `Jetpack Compose` (Funciones `@Composable`). Equivalente a `SwiftUI` / `Flutter Widgets`.
*   **ViewModels:** Extienden de `ViewModel`. Usan `StateFlow` o `MutableState` para el estado. Equivalente a `ObservableObject` (Swift) / `Bloc` (Flutter).

### 2. Componentes Reutilizables (Shared UI / Core)
*   Los widgets reutilizables vivirán en `core/ui/components` (ej: `CustomButton.kt`).

### 3. Domain (Dominio - El corazón de la app)
*   **Entities:** `data class` de Kotlin puros.
*   **Use Cases:** Clases con un único propósito (ej: `LoginUseCase`).
*   **Interfaces:** `interface` en Kotlin (Equivalente a `Protocol` en Swift).

### 4. Data (Datos)
*   **Repositories:** Implementación de interfaces.
*   **Data Sources:** Clases que usan `Retrofit`/`Ktor` o `Room`.
*   **DTOs:** Modelos para parsear JSON (usualmente con `@Serializable` de Kotlinx o Gson).

---

## 👨‍🏫 Flujo Paralelo (iOS & Android)
Para optimizar tokens, el agente NO imprimirá el código en el chat. Escribirá los archivos directamente en:
- `first_app` (Swift)
- `first_app_kotlin` (Kotlin)
El agente solo explicará las diferencias clave en el chat.

## 🎨 Paridad Visual (Design System 1:1)
Para lograr que la app de Android no se vea por defecto como "Material Design puro" y la de iOS como "iOS nativo puro", **todas** las vistas deben construirse usando un Design System personalizado. 
- NO se usarán componentes nativos de Compose (ej: `Button` básico) directamente en las pantallas. 
- Se crearán "Wrappers" (ej. `PrimaryButton`) en `core/ui/components` forzando colores, paddings y radios exactos para coincidir visualmente con SwiftUI.

Paquete base: `com.example.myapplication`
