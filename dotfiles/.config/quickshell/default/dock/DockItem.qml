import QtQuick

Item {
  id: root
  required property var app
  property var index: 0
  width: 48
  height: 48

  Rectangle {
    id: background
    anchors.fill: parent
    color: "transparent"
    radius: 12
  }

  Image {
    id: image
    anchors.fill: parent
    fillMode: Image.PreserveAspectFit
    source: "image://icon/" + root.app.appId
  }

  MouseArea {
    id: area
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    hoverEnabled: true

    onEntered: {
      background.color = "#11ffffff"
    }

    onExited: {
      background.color = "transparent"
    }

    onClicked: event => {
      switch (event.button) {
        case Qt.LeftButton:
          root.app.toplevels[root.index].activate();
          if (root.index == root.app.toplevels.length - 1) {
            root.index = 0;
          } else {
            root.index++;
          }
          break;
        case Qt.RightButton:
          break;
      }
      event.accepted = true;
    }
  }
}
