// Ui shim: Button - a themed push button.
// Matches the API the Hello Lock screens use: text, bordered, focusable, onClicked.
import QtQuick
import QtQuick.Controls as Controls
import qs.Commons

Controls.Button {
  id: root

  property bool bordered: false
  property bool focusable: false
  property bool selected: false

  focus: root.focusable
  hoverEnabled: true

  implicitWidth: Math.max(96, content.implicitWidth + 28)
  implicitHeight: 34

  font.family: "Oxanium"
  font.pixelSize: Style.font.bodySmall
  font.letterSpacing: 0.8

  background: Rectangle {
    radius: Math.min(Style.cornerRadius, 10)
    color: root.selected && bordered ? Util.alpha(Color.accent, 0.18)
      : (bordered ? "transparent" : (root.enabled ? Color.accent : Util.alpha(Color.accent, 0.35)))
    border.width: bordered ? 1 : 0
    border.color: root.selected ? Color.accent
      : Util.alpha(Color.foreground, root.hovered ? 0.55 : 0.3)
  }

  contentItem: Text {
    id: content
    text: root.text
    font: root.font
    color: root.selected ? Color.accent
      : (root.bordered ? Color.foreground : (root.enabled ? Color.background : Util.alpha(Color.background, 0.8)))
    elide: Text.ElideRight
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
  }
}
