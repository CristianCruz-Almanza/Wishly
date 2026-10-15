# 📱 Reglas del Proyecto: Clean Architecture en Swift

Este documento sirve como el ".agents" / guía maestra de arquitectura para el proyecto. Como asistente de IA, SIEMPRE leeré y seguiré estas directrices antes de implementar cualquier feature nueva.

## 🎯 Objetivo General
Mantener una arquitectura **SÓLIDA, escalable y testeable**, utilizando **Clean Architecture**. Además, cada implementación debe ser **altamente didáctica**, explicando los conceptos de Swift a un desarrollador con experiencia en Flutter.
¡Regla de oro: **Cero código repetido (DRY - Don't Repeat Yourself)**!

---

## 🏗️ Estructura: Clean Architecture + MVVM

Organizaremos el código combinando componentes globales (Core) y modulares (Features).

### 1. Presentation (UI)
*   **Views (Vistas):** Construidas con `SwiftUI`. 
    *   *Analogía en Flutter:* Son tus `StatelessWidget` o `StatefulWidget`. Solo se encargan de dibujar la interfaz de usuario.
*   **ViewModels:** Clases que manejan la lógica de presentación y el estado. 
    *   *Analogía en Flutter:* Son tu `ChangeNotifier` o `Bloc`. Se comunican con la vista mediante `@StateObject` o `@Observable`.

### 2. Componentes Reutilizables (Shared UI / Core)
*   En SwiftUI, los "Widgets" (Botones, TextFields, Cards) también son simplemente **Views**.
*   Todo componente que se use más de una vez DEBE ser extraído a un archivo independiente para ser reutilizable.
*   Estos vivirán en una carpeta global como `Core/UI/Components` para que cualquier Feature pueda consumirlos sin duplicar código.

### 3. Domain (Dominio - El corazón de la app)
*   **Entities (Entidades):** Modelos de negocio puros (`struct`). No dependen de ninguna librería externa.
*   **Use Cases (Casos de Uso):** Representan una acción específica del usuario (Ej: `LoginUserUseCase`).
*   **Interfaces (Protocolos):** Definen contratos. Equivalentes a las `abstract class` en Dart (Inversión de dependencias).

### 4. Data (Datos)
*   **Repositories:** Implementación de los protocolos del Dominio.
*   **Data Sources:** Clases que se comunican con la red (`URLSession`) o con la base de datos local.
*   **DTOs (Data Transfer Objects):** Modelos usados exclusivamente para parsear JSON (implementando `Codable`).

---

## 👨‍🏫 Reglas de Implementación (Instrucciones para el Agente)

Cada vez que el usuario pida implementar algo, el agente DEBE:
1.  **Explicar paso a paso:** Explicar qué hace cada archivo y hacer la analogía con Flutter.
2.  **Componentización:** Extraer sistemáticamente los elementos UI repetitivos a Vistas reutilizables en `Core/UI`. **NO REPETIR CÓDIGO.**
3.  **Aplicar Inyección de Dependencias:** Evitar dependencias fuertemente acopladas. Pasarlas por el constructor.
4.  **Usar Swift Moderno:** Favorecer `async / await` en lugar de completion handlers.
5.  **Mantener el código limpio (SOLID):** Clases con una única responsabilidad.
6.  **Paridad Visual (Design System 1:1):** Para lograr que iOS y Android se vean idénticos, NO confiaremos en los estilos por defecto del sistema operativo (que son distintos). Todas las vistas deben construirse usando un Design System personalizado estricto (colores, tipografías, padding, cornerRadius) implementado en `Core/UI`. Todo componente (ej. botones, inputs) DEBE ser empaquetado como un Widget reutilizable que fuerce la paridad visual.

---
**Estructura de Carpetas Base:**
```
Core/
├── UI/
│   ├── Components/ (Aquí van los "Widgets" reutilizables: CustomButton, AppTextField, etc.)
│   └── Modifiers/ (Modificadores visuales reutilizables)
├── Network/
└── Utils/

Features/
└── Auth/
    ├── Presentation/
    ├── Domain/
    └── Data/
```
