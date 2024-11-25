
# Gestión de Amigos y Ubicaciones

Este proyecto es una **prueba técnica** que permite registrar amigos, ubicaciones y asociar ubicaciones a amigos. Cada amigo puede tener una foto de perfil, y cada ubicación puede incluir un máximo de tres fotos.

## Getting Started

### Requisitos Previos
- **Flutter SDK**: [Instrucciones de instalación](https://flutter.dev/docs/get-started/install)
- Editor recomendado: **Visual Studio Code** o **Android Studio**
- Emulador o dispositivo físico configurado

### Instalación
1. Clona el repositorio:
   ```bash
   git clone https://github.com/DuvanAndresVelasquez/ubicaciones.git
   cd ubicaciones
Instala las dependencias de Flutter:


flutter pub get



flutter run


Descripción del Proyecto
Funcionalidades


Gestión de Amigos:

Registrar amigos con datos básicos (nombre, apellido, email, teléfono).
Subir una foto de perfil para cada amigo.
Gestión de Ubicaciones:

Registrar ubicaciones con nombre, descripción, y coordenadas opcionales.
Asociar hasta 3 fotos por ubicación.
Asociación de Amigos y Ubicaciones:

Asignar múltiples ubicaciones a un amigo.
Visualizar las ubicaciones asignadas a cada amigo.
Arquitectura
El proyecto sigue el enfoque Clean Architecture, estructurado en tres capas principales:

Data: Maneja las fuentes de datos locales mediante SQLite.
Domain: Contiene las entidades y casos de uso.
Presentation: Implementa la interfaz de usuario y la gestión de estado con MobX.

lib/
├── data/                # Fuentes de datos y repositorios
├── domain/              # Entidades y casos de uso
├── presentation/        # Interfaz de usuario y gestión de estado
└── main.dart            # Punto de entrada de la aplicación



### Uso
### Registro de Amigos
Accede a la pestaña "Amigos".
Haz clic en el botón + para agregar un nuevo amigo.
Ingresa los datos del amigo y selecciona una foto de perfil.
### Registro de Ubicaciones
Accede a la pestaña "Ubicaciones".
Haz clic en el botón + para agregar una nueva ubicación.
Completa los datos de la ubicación y sube hasta 3 fotos.
### Asignar Ubicaciones a un Amigo
Desde la lista de amigos, selecciona un amigo.
Haz clic en el botón "Asignar Ubicación".
Elige una ubicación de la lista para asignarla.
### Tecnologías Utilizadas
1. Flutter: Framework principal para la interfaz de usuario.
2. SQLite: Base de datos local para persistencia.
3. MobX: Gestión de estado reactiva.
