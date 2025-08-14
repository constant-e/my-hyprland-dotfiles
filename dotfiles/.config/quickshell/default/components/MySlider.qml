import QtQuick
import QtQuick.Controls

Item {
  id: root
  required property var icon
  required property var from
  required property var to
  required property var value
  property var clickable: false
  implicitHeight: myText.contentHeight + 10
  implicitWidth: image.width + slider.width + myText.contentWidth + 20

  signal moved()

  Image {
    id: image
    anchors {
      left: parent.left
      verticalCenter: parent.verticalCenter
      rightMargin: 5
    }
    height: myText.contentHeight
    fillMode: Image.PreserveAspectFit
    source: root.icon
  }

  Slider {
    id: slider
    anchors {
      left: image.right
      verticalCenter: parent.verticalCenter
      margins: 5
    }
    from: root.from
    to: root.to
    value: root.value
    onMoved: {
      root.value = slider.value
      root.moved()
    }
  }

  MyText {
    id: myText
    anchors {
      left: slider.right
      verticalCenter: parent.verticalCenter
      leftMargin: 5
    }
    text: Math.round((value - from)/(to - from) * 100) + "%"
  }
}