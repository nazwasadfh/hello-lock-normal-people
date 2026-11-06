pragma Singleton
// Standalone-port shim: replaces Omarchy's `qs.Commons` Util helpers.
import QtQuick

QtObject {
  // Return a copy of a color with its alpha set to `a` (0-1).
  function alpha(c, a) {
    return Qt.rgba(c.r, c.g, c.b, a)
  }
}
