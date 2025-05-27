# hll-geofences – Pterodactyl Docker Image

![Docker](https://img.shields.io/badge/Docker-Automated-blue?logo=docker)
![License](https://img.shields.io/github/license/wienni112/hll-geofences-image)

Ein Docker-Image für das [hll-geofences](https://github.com/2KU77B0N3S/hll-geofences) Projekt, vorbereitet für den Einsatz mit [Pterodactyl](https://pterodactyl.io/).

Dieses Image kompiliert automatisch das Go-Projekt und stellt ein ausführbares Binary bereit, das direkt über ein Pterodactyl-Egg genutzt werden kann.

## 🔧 Features

- Kompatibel mit Pterodactyl v1.x
- Automatischer Go-Build beim Image-Build
- Beispielkonfiguration (`config.yml`) wird bereitgestellt
- Keine zusätzlichen Install-Skripte nötig

## 🐳 Docker Image

Veröffentlichung über [GitHub Container Registry (GHCR)](https://ghcr.io/):

```
ghcr.io/wienni112/hll-geofences:latest
```

## 📁 Verzeichnisstruktur

```txt
.
├── Dockerfile          # Build-Definition
├── entrypoint.sh       # Yolks-kompatibler Entrypoint
└── .github/
    └── workflows/
        └── docker.yml  # GitHub Actions CI für automatische Builds
```

## 🚀 Verwendung mit Pterodactyl

### Docker Image

```
ghcr.io/wienni112/hll-geofences:latest
```

### Startup Command

```
./hll-geofences
```

### Stop Command

```
^C
```

### Install Script

❌ **Nicht notwendig** – das Binary wird beim Image-Build erzeugt.

## 🔄 Automatische Builds

Jeder Push auf den `main`-Branch triggert den Build-Prozess und veröffentlicht ein neues Image nach `ghcr.io/wienni112/hll-geofences`.

## ⚖️ Lizenz

Dieses Repository steht unter der **MIT License**.  
Das enthaltene Projekt [hll-geofences](https://github.com/2KU77B0N3S/hll-geofences) wird ebenfalls unter MIT-Lizenz veröffentlicht.

## 💬 Support

Fragen oder Vorschläge?  
Erstelle ein Issue oder kontaktiere mich auf GitHub.
