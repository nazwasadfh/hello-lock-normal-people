// Ui shim: NumberField - a small numeric field with a label.
// Matches Omarchy's Ui API: label, from, to, value, onModified(v).
import QtQuick
import QtQuick.Controls as Controls
import qs.Commons

Column {
  id: root

  spacing: 4

  property string label: ""
  property int from: 0
  property int to: 100
  property int value: 0
  signal modified(var v)

  onValueChanged: field.text = String(value)
  Component.onCompleted: field.text = String(value)

  function commit() {
    var v = parseInt(field.text === "" ? String(root.value) : field.text)
    if (isNaN(v)) v = root.value
    v = Math.max(root.from, Math.min(root.to, v))
    field.text = String(v)
    if (v !== root.value) { root.value = v; root.modified(v) }
  }

  function bump(delta) {
    var v = Math.max(root.from, Math.min(root.to, root.value + delta))
    root.value = v
    root.modified(v)
  }

  Text {
    text: root.label
    color: Util.alpha(Color.foreground, 0.8)
    font.family: "Oxanium"
    font.pixelSize: Style.font.bodySmall
    visible: root.label.length > 0
  }

  Row {
    spacing: 6

    component StepButton: Controls.Button {
      property string glyph: ""
      width: 30; height: 34
      hoverEnabled: true
      background: Rectangle {
        radius: 8
        color: parent.hovered ? Util.alpha(Color.foreground, 0.16) : Util.alpha(Color.foreground, 0.08)
        border.width: 1
        border.color: Util.alpha(Color.foreground, 0.25)
      }
      contentItem: Text { text: glyph; color: Color.foreground; font.pixelSize: 16; anchors.fill: parent; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
    }

    StepButton { glyph: "-"; onClicked: root.bump(-1) }

    Controls.TextField {
      id: field
      width: 62; height: 34
      horizontalAlignment: TextInput.AlignHCenter
      color: Color.foreground
      placeholderTextColor: Color.lock.placeholder
      font.family: "Oxanium"
      font.pixelSize: Style.font.body
      selectByMouse: true
      validator: IntValidator { bottom: root.from; top: root.to }

      onAccepted: root.commit()
      onEditingFinished: root.commit()
      onTextEdited: {
        var v = parseInt(field.text)
        if (!isNaN(v)) {
          v = Math.max(root.from, Math.min(root.to, v))
          if (v !== root.value) { root.value = v; root.modified(v) }
        }
      }
    }

    StepButton { glyph: "+"; onClicked: root.bump(1) }
  }
}
