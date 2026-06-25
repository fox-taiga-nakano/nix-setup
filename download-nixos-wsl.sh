#!/usr/bin/env bash
set -euo pipefail

REPO="nix-community/NixOS-WSL"
ASSET_NAME="nixos.wsl"
DOWNLOAD_URL="https://github.com/${REPO}/releases/latest/download/${ASSET_NAME}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_OUTPUT_DIR="${SCRIPT_DIR}/assets"
OUTPUT_DIR="${1:-${DEFAULT_OUTPUT_DIR}}"
OUTPUT_FILE="${OUTPUT_DIR}/${ASSET_NAME}"

mkdir -p "${OUTPUT_DIR}"

echo "Download URL: ${DOWNLOAD_URL}"
echo "Output file : ${OUTPUT_FILE}"

if command -v curl >/dev/null 2>&1; then
  curl -fL --retry 3 --retry-delay 2 \
    -o "${OUTPUT_FILE}" \
    "${DOWNLOAD_URL}"
elif command -v wget >/dev/null 2>&1; then
  wget --tries=3 \
    -O "${OUTPUT_FILE}" \
    "${DOWNLOAD_URL}"
else
  echo "Error: curl または wget が必要です。" >&2
  exit 1
fi

if [ ! -s "${OUTPUT_FILE}" ]; then
  echo "Error: ダウンロードしたファイルが空です: ${OUTPUT_FILE}" >&2
  exit 1
fi

echo "Downloaded: ${OUTPUT_FILE}"
echo
echo "PowerShell でインストールする場合:"
echo "wsl --install --from-file \"${OUTPUT_FILE}\""
