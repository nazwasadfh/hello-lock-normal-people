pragma Singleton
// Standalone standalone-port shim: this replaces Omarchy's `qs.Commons` Color
// singleton so the upstream QML files are untouched. Values follow the Tokyo
// Night palette (Omarchy's default); copy real values from your own theme's
// config here if you use a different one.
import QtQuick

QtObject {
  readonly property color background: "#1a1b26"
  readonly property color foreground: "#c0caf5"
  readonly property color accent: "#7aa2f7"
  readonly property color urgent: "#f7768e"

  readonly property QtObject lock: QtObject {
    readonly property color text: "#c0caf5"
    readonly property color textError: "#f7768e"
    readonly property color placeholder: "#565f89"
    readonly property color borderActive: "#7aa2f7"
    readonly property color borderError: "#f7768e"
    readonly property color selection: "#33467c"
  }
}
