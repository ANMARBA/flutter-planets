Home ("/home")
----------------------------------------

### Estructura general de la pantalla
*   Encabezado: título **“Explora el Sistema Solar”** y subtítulo.
*   Fondo animado: campo de estrellas con **“twinkle”** (parpadeo suave) + nebulosas radiales.
*   Mini sistema solar: un **sol** central con **Hero** y tres anillos orbitando con “planetas” decorativos.
*   CTA accesible: botón **“Ver Planetas”** (con Semantics y Key de test) que navega a **/planets**.

### Navegación
*   Ruta actual: **/home**.
*   Ruta destino del CTA: **/planets**.
*   Accesibilidad: el botón tiene etiqueta semántica **“Ver Planetas”**.

### Clases y componentes
1.  **HomePage**
    *   **Tipo:** StatefulWidget
    *   **Rol:** Pantalla principal.

2.  **Star**
    *   **Tipo:** modelo interno
    *   **Rol:** Define una estrella individual del campo estelar.

3.  **StarFieldPainter**
    *   **Tipo:** CustomPainter
    *   **Rol:** Dibuja el campo de estrellas con **twinkle**.

4.  **Nebula**
    *   **Tipo:** StatelessWidget
    *   **Rol:** Nebulosas suaves (círculos con gradiente radial).

5.  **RotatingRing**
    *   **Tipo:** StatelessWidget
    *   **Rol:** Órbita que rota lentamente y contiene planetas en su perímetro.

6.  **PlanetDot**
    *   **Tipo:** StatelessWidget
    *   **Rol:** Puntos de color que simulan **planetas** en las órbitas.

### Accesibilidad y testabilidad
*   Semantics en el CTA (“Ver Planetas”) para lectores de pantalla.
*   Key('seePlanetsButton') para pruebas de widget/integración.
*   Contraste: tipografías claras sobre fondo oscuro; sombras en el “sol”.

### Resumen
La Home entrega un diseño temático de planetas con animaciones ligeras y un CTA claro para continuar el flujo. La UI se organiza en componentes internos reutilizables (pintor de estrellas, nebulosas, anillos y planetas).