// Ui shim: ButtonGroup - a row of choice chips over {value, label} options.
// Matches Omarchy's Ui API: options, value, onChanged(value).
import QtQuick
import qs.Commons

Row {
  id: root

  spacing: 8

  property var options: []
  property string value: ""
  signal changed(var v)

  Repeater {
    model: root.options

    Rectangle {
      id: chip

      required property var modelData
      required property int index

      property bool selected: root.value === String(modelData.value)

      width: chipText.implicitWidth + 26
      height: 34
      radius: 17
      color: selected ? Color.accent : Util.alpha(Color.foreground, 0.06)
      border.width: 1
      border.color: selected ? Color.accent : Util.alpha(Color.foreground, 0.25)

      Text {
        id: chipText
        anchors.centerIn: parent
        text: modelData.label
        color: parent.selected ? Color.background : Color.foreground
        font.family: "Oxanium"
        font.pixelSize: Style.font.bodySmall
        font.letterSpacing: 0.6
      }

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
          root.value = chip.modelData.value
          root.changed(chip.modelData.value)
        }
      }
    }
  }
}
