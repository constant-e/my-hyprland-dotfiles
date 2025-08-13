import QtQuick
import Quickshell
import "root:/components"

Item {
  id: root
  implicitHeight: icon.height
  implicitWidth: icon.width

  Image {
    id: icon
    anchors.centerIn: parent
    height: 20
    width: 20
    source: "image://icon/notification-symbolic"
  }

  MouseArea {
    id: area
    anchors.fill: parent
    onClicked: event => {
      popup.visible = !popup.visible
    }
  }

  PopupWindow {
    id: popup
    property var window: root.QsWindow.window
    anchor {
      window: window
      // Here 5 is my monitor_gap in hyprland
      rect.x: window.width - popup.implicitWidth - 5
      rect.y: window.height + 5
    }
    implicitWidth: 300
    color: "transparent"

    Rectangle {
      id: background
      anchors.fill: parent

      color: Style.style.background
      radius: 12      
    }
  }
}
