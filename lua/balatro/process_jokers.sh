#!/bin/bash

# Directorios
JOKERS_DIR="./jokers"
RAWS_DIR="./raws"
IMG2ART_CMD="img2art"

# Verificar que img2art está instalado
if ! command -v $IMG2ART_CMD &>/dev/null; then
  echo "Error: img2art no está instalado o no está en el PATH"
  exit 1
fi

# Crear directorio raws si no existe
mkdir -p "$RAWS_DIR"

# Procesar cada imagen en la carpeta jokers
for IMAGE_PATH in "$JOKERS_DIR"/*.png; do
  # Obtener el nombre base del archivo (sin extensión)
  FILENAME=$(basename -- "$IMAGE_PATH")
  JOKER_NAME="${FILENAME%.*}"

  # Corregir nombre para el archivo Lua (reemplazar espacios y guiones bajos)
  LUA_NAME=$(echo "$JOKER_NAME" | tr ' ' '_' | tr '-' '_')

  # Construir ruta de salida
  OUTPUT_LUA="$RAWS_DIR/$LUA_NAME.lua"

  echo "Procesando: $JOKER_NAME -> $OUTPUT_LUA"

  # Ejecutar img2art con los parámetros especificados
  $IMG2ART_CMD "$IMAGE_PATH" \
    --scale 0.4 \
    --threshold 120 \
    --alpha \
    --save-raw "$OUTPUT_LUA"

  # Verificar si el comando tuvo éxito
  if [ $? -ne 0 ]; then
    echo "Error al procesar $IMAGE_PATH"
  fi
done

echo "Proceso completado. Archivos generados en $RAWS_DIR"
