#!/usr/bin/env bash
set -euo pipefail

# Run from the project directory even when called from elsewhere.
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

usage() {
  cat <<'HELP'
Usage: ./expo-commands.sh <command>

  start       Start Expo: npx expo start
  lan         Start on Wi-Fi: npx expo start --lan
  build       Build an Android APK in EAS cloud (preview profile)
  production  Build an Android AAB in EAS cloud for Google Play
  help        Show these commands

For LAN, keep your phone and laptop on the same Wi-Fi and allow port 8081.
Cloud builds require an Expo account, but no local Java or Android SDK.
Download the finished APK from the build link or Expo dashboard.
HELP
}

case "${1:-help}" in
  start)
    exec npx expo start
    ;;
  lan)
    exec npx expo start --lan
    ;;
  build)
    exec npx eas-cli@latest build --platform android --profile preview
    ;;
  production)
    exec npx eas-cli@latest build --platform android --profile production
    ;;
  help|-h|--help)
    usage
    ;;
  *)
    printf 'Unknown command: %s\n\n' "$1" >&2
    usage >&2
    exit 1
    ;;
esac
