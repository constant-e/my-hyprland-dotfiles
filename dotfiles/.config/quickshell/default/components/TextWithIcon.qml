import QtQuick

Item {
  id: root
  required property var text
  required property var icon
  implicitHeight: myText.implicitHeight + 4
  // icon left margin (2) + space (5) + text right margin (2)
  implicitWidth: image.width + myText.implicitWidth + 9

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
    height: parent.height - 4
    fillMode: Image.PreserveAspectFit
    source: root.icon
  }

  MyText {
    anchors {
      left: image.right
      verticalCenter: parent.verticalCenter
      leftMargin: 5
    }
    id: myText
    text: root.text
  }

  MouseArea {
    id: area
    anchors.fill: parent
    hoverEnabled: true

    onEntered: {
      background.color = "#11ffffff"
    }

    onExited: {
      background.color = "transparent"
    }

    onClicked: event => {
      root.clicked(event)
    }
  }
}
