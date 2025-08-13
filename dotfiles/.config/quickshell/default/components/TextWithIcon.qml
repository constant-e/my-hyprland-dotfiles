import QtQuick

Item {
  id: root
  required property var text
  required property var icon
  property var clickable: false
  implicitHeight: myText.contentHeight + 4
  // icon left margin (2) + space (5) + text right margin (2)
  implicitWidth: image.width + myText.contentWidth + 9

  signal clicked(var event)

  Rectangle {
    id: background
    anchors.fill: parent
    color: "transparent"
    radius: 4
  }

  Image {
    id: image
    anchors {
      left: parent.left
      verticalCenter: parent.verticalCenter
      margins: 2
    }
    height: myText.contentHeight
    fillMode: Image.PreserveAspectFit
    source: root.icon
  }

  MyText {
    id: myText
    anchors {
      left: image.right
      verticalCenter: parent.verticalCenter
      leftMargin: 5
    }
    text: root.text
  }

  MouseArea {
    id: area
    anchors.fill: parent
    hoverEnabled: true

    onEntered: {
      if (root.clickable) {
        background.color = "#11ffffff"
      }
    }

    onExited: {
      background.color = "transparent"
    }

    onClicked: event => {
      if (root.clickable) {
        root.clicked(event)
      }
    }
  }
}
