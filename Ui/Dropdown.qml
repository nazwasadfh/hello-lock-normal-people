// Ui shim: Dropdown - a pick list over plain {value, label} options.
// Matches Omarchy's Ui API the Hello Lock settings screen uses:
// width, showLabel, options, value (string), onChanged(value).
import QtQuick
import QtQuick.Controls as Controls
import qs.Commons

Item {
  id: root

  implicitHeight: root.showLabel && root.label.length > 0
    ? labelItem.implicitHeight + combo.implicitHeight + 4
    : combo.implicitHeight

  property bool showLabel: true
  property string label: ""
  property var options: []
  property string value: ""
  signal changed(var v)

  onValueChanged: combo.syncToValue()
  onOptionsChanged: combo.syncToValue()
  Component.onCompleted: combo.syncToValue()

  Text {
    id: labelItem
    visible: root.showLabel && root.label.length > 0
    anchors.top: parent.top
    anchors.left: parent.left
    text: root.label
    color: Util.alpha(Color.foreground, 0.8)
    font.family: "Oxanium"
    font.pixelSize: Style.font.bodySmall
  }

  Controls.ComboBox {
    id: combo
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    visible: root.showLabel || root.value !== "" || root.options.length > 0
    model: root.options
    textRole: "label"
    valueRole: "value"
    font.family: "Oxanium"
    font.pixelSize: Style.font.bodySmall

    function syncToValue() {
      if (currentValue === root.value) return
      for (var i = 0; i < root.options.length; i++) {
        if (String(root.options[i].value) === root.value) {
          currentIndex = i
          return
        }
      }
    }

    onActivated: function(index) {
      var v = root.options[index] && root.options[index].value
      if (v !== undefined) { root.value = String(v); root.changed(v) }
    }
  }
}
