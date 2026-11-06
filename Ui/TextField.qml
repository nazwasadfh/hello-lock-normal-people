// Ui shim: TextField - wraps QtQuick.Controls.TextField with the theme look.
// Used API: width, text, placeholderText, maximumLength, horizontalAlignment,
// validator, font, onTextEdited - all native to the control.
import QtQuick.Controls as Controls
import qs.Commons

Controls.TextField {
  color: Color.foreground
  placeholderTextColor: Util.alpha(Color.lock.placeholder, 0.9)
  selectionColor: Color.lock.selection
  selectedTextColor: Color.foreground
  font.family: "Oxanium"
  font.pixelSize: Style.font.body
  selectByMouse: true
  padding: 10
}
