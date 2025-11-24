# 🚀 Guía Completa de Despliegue

## 📦 Archivos que DEBES subir a tu repositorio

```
tu-repositorio/
├── app.py                 ✅ (Backend API)
├── index.html            ✅ (Frontend)
├── requirements.txt      ✅ (Dependencias Python)
├── Procfile             ✅ (Configuración Railway)
├── runtime.txt          ✅ (Versión Python)
├── railway.json         ✅ (Configuración Railway)
├── .gitignore           ✅ (Archivos a ignorar)
├── README.md            ✅ (Documentación)
├── DEPLOYMENT.md        ✅ (Esta guía)
└── deploy.sh            ✅ (Script de despliegue) [Opcional]
```

## 🎯 Paso a Paso - Despliegue Completo

### PASO 1: Preparar el Repositorio Local

1. **Crea una carpeta para tu proyecto:**
```bash
mkdir bcp-acuerdos
cd bcp-acuerdos
```

2. **Crea todos los archivos necesarios** (copia el contenido de cada artifact)

3. **Haz el archivo deploy.sh ejecutable** (solo Linux/Mac):
```bash
chmod +x deploy.sh
```

### PASO 2: Crear Repositorio en GitHub

1. Ve a [github.com](https://github.com) y haz login

2. Click en el botón **"New"** (arriba a la derecha, al lado de tu avatar)

3. Configura tu repositorio:
   - **Repository name**: `bcp-acuerdos` (o el nombre que prefieras)
   - **Description**: `Sistema de generación de acuerdos BCP`
   - **Public** o **Private** (tu elección)
   - ❌ NO marques "Add a README file"
   - ❌ NO agregues .gitignore
   - ❌ NO agregues licencia
   
4. Click en **"Create repository"**

5. **Copia la URL** del repositorio que aparece (algo como: `https://github.com/tu-usuario/bcp-acuerdos.git`)

### PASO 3: Subir Archivos a GitHub

**Opción A - Usando el script automático:**

```bash
./deploy.sh
```

Sigue las instrucciones en pantalla.

**Opción B - Manual:**

```bash
# Inicializar repositorio
git init

# Agregar todos los archivos
git add .

# Crear commit
git commit -m "Initial commit - Sistema BCP"

# Cambiar a rama main
git branch -M main

# Agregar remote (reemplaza con TU URL)
git remote add origin https://github.com/TU-USUARIO/bcp-acuerdos.git

# Subir a GitHub
git push -u origin main
```

### PASO 4: Desplegar Backend en Railway

1. **Ve a [Railway.app](https://railway.app)**

2. **Click en "Start a New Project"**

3. **Selecciona "Deploy from GitHub repo"**

4. **Autoriza Railway** a acceder a tus repositorios

5. **Selecciona tu repositorio** `bcp-acuerdos`

6. **Configura las Variables de Entorno:**
   - Click en tu proyecto
   - Click en "Variables"
   - Agrega las siguientes:
   ```
   DB_HOST=172.16.80.225
   DB_PORT=5432
   DB_NAME=ASIGNACION
   DB_USER=postgres
   DB_PASSWORD=tu_password_real
   ```

7. **Espera a que termine el deploy** (2-5 minutos)

8. **Obtén tu URL:**
   - Click en "Settings"
   - Busca "Domains"
   - Click en "Generate Domain"
   - **COPIA esta URL** (ej: `https://bcp-acuerdos-production.up.railway.app`)

9. **Prueba tu API:**
   - Abre en tu navegador: `https://TU-URL.railway.app/api/health`
   - Deberías ver: `{"status":"ok","message":"API funcionando correctamente"}`

### PASO 5: Actualizar Frontend con la URL del Backend

1. **Edita el archivo `index.html`** en tu repositorio local

2. **Busca esta línea** (aproximadamente línea 16):
```javascript
const API_URL = 'http://localhost:5000/api';
```

3. **Cámbiala por tu URL de Railway:**
```javascript
const API_URL = 'https://TU-URL.railway.app/api';
```

4. **Guarda el archivo**

5. **Sube los cambios a GitHub:**
```bash
git add index.html
git commit -m "Update API URL for production"
git push
```

### PASO 6: Activar GitHub Pages

1. **Ve a tu repositorio en GitHub**

2. **Click en "Settings"** (arriba)

3. **Scroll down y click en "Pages"** (menú izquierdo)

4. **Configura:**
   - **Source**: Deploy from a branch
   - **Branch**: `main`
   - **Folder**: `/ (root)`

5. **Click en "Save"**

6. **Espera 1-2 minutos**

7. **Actualiza la página** y verás un mensaje:
   ```
   Your site is live at https://tu-usuario.github.io/bcp-acuerdos/
   ```

8. **¡Click en el link y prueba tu aplicación!**

## 🎉 ¡Listo! Tu Aplicación está en Producción

### URLs Finales:
- **Frontend**: `https://tu-usuario.github.io/bcp-acuerdos/`
- **Backend**: `https://tu-app.railway.app`

## 🧪 Probar la Aplicación

1. **Abre el frontend en tu navegador**

2. **Ingresa un IDC** en el campo correspondiente

3. **Click en "Buscar"** - debería conectarse a tu base de datos

4. **Completa los datos** del cliente y productos

5. **Click en "Generar Documento Word"** - debería descargar un archivo .docx

## ⚠️ Solución de Problemas Comunes

### Error: "Failed to fetch"
- Verifica que la URL del API en `index.html` sea correcta
- Asegúrate de que el backend esté corriendo en Railway
- Revisa las variables de entorno en Railway

### Error: "Cliente no encontrado"
- Verifica la conexión a la base de datos
- Revisa las credenciales en Railway (Variables)
- Asegúrate de que el IDC exista en la base de datos

### El sitio no se ve en GitHub Pages
- Espera 5-10 minutos después de activar Pages
- Verifica que el archivo se llame exactamente `index.html`
- Asegúrate de que esté en la raíz del repositorio

### Error de CORS
- Verifica que Flask-CORS esté instalado
- Revisa que `CORS(app)` esté en `app.py`

## 🔄 Actualizar la Aplicación

Cuando hagas cambios:

```bash
git add .
git commit -m "Descripción de los cambios"
git push
```

- **Backend**: Railway se actualizará automáticamente
- **Frontend**: GitHub Pages se actualizará en 1-2 minutos

## 📊 Monitoreo

### Railway:
- Ve a tu proyecto en Railway
- Click en "Deployments" para ver logs
- Click en "Metrics" para ver uso de recursos

### GitHub Pages:
- Settings → Pages para ver el estado
- Actions → Pages build para ver builds

## 🔒 Seguridad para Producción

**IMPORTANTE**: Antes de usar en producción real:

1. ✅ Cambia todas las contraseñas de la base de datos
2. ✅ Implementa autenticación de usuarios
3. ✅ Usa HTTPS para todo
4. ✅ Agrega rate limiting al API
5. ✅ Configura CORS apropiadamente
6. ✅ Valida todos los inputs
7. ✅ Implementa logging apropiado
8. ✅ Haz backups regulares de la base de datos

## 💡 Tips Adicionales

- **Railway gratis**: 500 horas/mes (suficiente para pruebas)
- **GitHub Pages**: Gratis e ilimitado
- **Base de datos**: Considera usar Railway PostgreSQL para producción
- **Dominio propio**: Puedes agregar un dominio custom en Railway y GitHub Pages

## 📞 ¿Necesitas Ayuda?

Si tienes problemas:
1. Revisa los logs en Railway
2. Abre las DevTools del navegador (F12) y revisa la consola
3. Verifica que todas las URLs sean correctas
4. Confirma que las variables de entorno estén configuradas

## ✅ Checklist Final

Antes de considerarlo completo, verifica:

- [ ] Backend desplegado en Railway
- [ ] Variables de entorno configuradas
- [ ] API responde en `/api/health`
- [ ] Frontend desplegado en GitHub Pages
- [ ] URL del API actualizada en index.html
- [ ] Búsqueda de clientes funciona
- [ ] Generación de documentos funciona
- [ ] Aplicación es accesible desde internet

---

**¡Felicidades! Tu aplicación está en producción. 🎉**
