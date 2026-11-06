// Ui shim: Toggle - a labelled switch row (label, description, check state).
// Matches the API the Hello Lock settings screen uses from Omarchy's Ui.
import QtQuick
import QtQuick.Controls as Controls
import qs.Commons

Item {
  id: root

  implicitWidth: label.length > 0 || description.length > 0 ? 360 : 60
  implicitHeight: Math.max(34, textCol.implicitHeight)

  property string label: ""
  property string description: ""
  property bool checked: false
  signal clicked()

  Column {
    id: textCol
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.rightMargin: 70
    anchors.verticalCenter: parent.verticalCenter
    spacing: 3

    Text {
      visible: root.label.length > 0
      text: root.label
      color: Color.foreground
      font.family: "Oxanium"
      font.pixelSize: Style.font.body
    }
    Text {
      visible: root.description.length > 0
      width: parent.width
      text: root.description
      color: Util.alpha(Color.foreground, 0.62)
      font.family: "Oxanium"
      font.pixelSize: Style.font.bodySmall
      wrapMode: Text.WordWrap
    }
  }

  Controls.Switch {
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    checked: root.checked
    onToggled: { root.checked = checked; root.clicked() }
  }
}
