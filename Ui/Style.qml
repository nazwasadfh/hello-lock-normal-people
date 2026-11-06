pragma Singleton
// Standalone-port shim: replaces Omarchy's `qs.Ui` Style singleton.
// Both bundled fonts are loaded by Service.qml (FontLoader), so the family
// names resolve app-wide without a system install.
import QtQuick

QtObject {
  readonly property int cornerRadius: 12

  readonly property QtObject font: QtObject {
    readonly property string family: "Oxanium"
    readonly property string familyMono: "Share Tech Mono"
    readonly property int displayLarge: 34
    readonly property int heading: 18
    readonly property int title: 16
    readonly property int subtitle: 14
    readonly property int body: 13
    readonly property int bodySmall: 11
  }
}
