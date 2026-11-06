// Ui shim: PanelSlider - a horizontal slider drawing itself from the "bar"
// colour bag ({foreground, background, urgent}).
// Matches Omarchy's Ui API: bar, minimum, maximum, step, value, onMoved, onReleased.
import QtQuick

Item {
  id: root

  implicitHeight: 28

  property var bar: null          // QtObject: { foreground, background, urgent }
  property real minimum: 0
  property real maximum: 1
  property real step: 0
  property real value: 0          // follows the binding; dragging reports via signals

  signal moved(var v)
  signal released(var v)

  onValueChanged: fill.requestPaint()

  function snap(v) {
    var clamped = Math.max(minimum, Math.min(maximum, v))
    if (step > 0) {
      var n = Math.round((clamped - minimum) / step)
      clamped = Math.min(maximum, minimum + n * step)
    }
    return clamped
  }

  function paintFraction() {
    var span = cursorDrag > 0 ? cursorDrag : value
    return (maximum > minimum) ? (span - minimum) / (maximum - minimum) : 0
  }

  property real cursorDrag: 0

  Canvas {
    id: fill
    anchors.fill: parent
    onPaint: {
      var ctx = getContext("2d")
      ctx.clearRect(0, 0, width, height)
      // rail
      ctx.fillStyle = (root.bar && root.bar.background) || "#ffffff22"
      roundBar(ctx, 0, width, height * 0.35)
      // fill
      var w = Math.max(height * 0.35, width * root.paintFraction())
      ctx.fillStyle = (root.bar && root.bar.foreground) || "#ffffff"
      roundBar(ctx, 0, w, height * 0.35)
      // handle
      ctx.beginPath()
      ctx.arc(Math.max(6, Math.min(width - 6, w)) - 6, height / 2, 9, 0, Math.PI * 2)
      ctx.fillStyle = (root.bar && root.bar.urgent) || "#ffffff"
      ctx.fill()
    }
    function roundBar(ctx, x, w, h) {
      var r = h / 2
      ctx.beginPath()
      ctx.moveTo(x + r, (height - h) / 2)
      ctx.arc(x + w - r, (height - h) / 2 + r, r, -Math.PI / 2, Math.PI / 2)
      ctx.arc(x + r, (height - h) / 2 + r, r, Math.PI / 2, Math.PI * 1.5)
      ctx.closePath()
      ctx.fill()
    }
  }

  MouseArea {
    id: dragArea
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    function valueAt(x) { return root.snap(root.minimum + (x / width) * (root.maximum - root.minimum)) }
    onPressed: {
      root.cursorDrag = root.snap(root.minimum + (mouse.x / width) * (root.maximum - root.minimum))
      root.fill.requestPaint()
    }
    onPositionChanged: {
      if (pressed) {
        root.cursorDrag = root.snap(root.minimum + (mouse.x / width) * (root.maximum - root.minimum))
        root.fill.requestPaint()
        root.moved(root.cursorDrag)
      }
    }
    onReleased: {
      root.value = root.cursorDrag
      root.released(root.value)
      root.cursorDrag = 0
      root.fill.requestPaint()
    }
  }
}
