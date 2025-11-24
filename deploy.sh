#!/bin/bash

echo "🚀 Script de Despliegue - BCP Acuerdos"
echo "======================================"
echo ""

# Verificar si Git está instalado
if ! command -v git &> /dev/null; then
    echo "❌ Git no está instalado. Por favor instala Git primero."
    exit 1
fi

# Verificar si estamos en un repositorio Git
if [ ! -d .git ]; then
    echo "📦 Inicializando repositorio Git..."
    git init
    echo "✅ Repositorio inicializado"
else
    echo "✅ Repositorio Git detectado"
fi

# Agregar todos los archivos
echo ""
echo "📝 Agregando archivos..."
git add .

# Crear commit
echo ""
echo "💾 Creando commit..."
read -p "Mensaje del commit (Enter para usar mensaje por defecto): " commit_msg
if [ -z "$commit_msg" ]; then
    commit_msg="Actualización del sistema BCP"
fi
git commit -m "$commit_msg"

# Verificar si ya existe un remote
if git remote | grep -q "origin"; then
    echo "✅ Remote 'origin' ya existe"
else
    echo ""
    echo "🔗 Configurar repositorio remoto"
    read -p "URL del repositorio GitHub (https://github.com/usuario/repo.git): " repo_url
    if [ ! -z "$repo_url" ]; then
        git remote add origin "$repo_url"
        echo "✅ Remote agregado"
    else
        echo "⚠️  No se agregó remote. Puedes hacerlo manualmente después."
    fi
fi

# Cambiar a rama main si es necesario
current_branch=$(git branch --show-current)
if [ "$current_branch" != "main" ]; then
    echo ""
    echo "🔄 Cambiando a rama 'main'..."
    git branch -M main
fi

# Push
echo ""
read -p "¿Deseas hacer push a GitHub ahora? (s/n): " do_push
if [ "$do_push" = "s" ] || [ "$do_push" = "S" ]; then
    echo "⬆️  Subiendo cambios a GitHub..."
    git push -u origin main
    echo "✅ Cambios subidos exitosamente"
fi

echo ""
echo "✅ ¡Despliegue completado!"
echo ""
echo "📋 Próximos pasos:"
echo "1. Backend: Despliega en Railway.app"
echo "   - Ve a https://railway.app"
echo "   - Conecta tu repositorio"
echo "   - Configura las variables de entorno"
echo ""
echo "2. Frontend: Activa GitHub Pages"
echo "   - Ve a Settings → Pages en tu repo"
echo "   - Selecciona rama 'main' y carpeta '/ (root)'"
echo "   - Actualiza la URL del API en index.html"
echo ""
echo "🎉 ¡Listo para usar!"
