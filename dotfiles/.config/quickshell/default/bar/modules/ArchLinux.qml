import QtQuick
import QtQuick.Layouts
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
    source: "image://icon/distributor-logo-archlinux"
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
      rect.x: 5
      rect.y: window.height + 5
    }
    implicitWidth: 300
    color: "transparent"

    Rectangle {
      id: background
      anchors.fill: parent
      color: Style.style.backgroundSolid
      radius: 12      
    }

    Image {
      id: popupIcon
      anchors {
        left: parent.left
        verticalCenter: parent.verticalCenter
        margins: 10
      }
      height: parent.height - 20
      fillMode: Image.PreserveAspectFit
      source: "image://icon/distributor-logo-archlinux"
    }

    ColumnLayout {
      anchors {
        left: popupIcon.right
        verticalCenter: parent.verticalCenter
        leftMargin: 10
      }
      spacing: 5

      TextWithIcon {
        text: "Log Out"
        icon: "image://icon/system-log-out-symbolic"
        clickable: true
        onClicked: {
          Quickshell.execDetached(["hyprctl", "dispatch", "exit"])
        }
      }

      TextWithIcon {
        text: "Reboot"
        icon: "image://icon/system-reboot-symbolic"
        clickable: true
        onClicked: {
          Quickshell.execDetached(["reboot"])
        }
      }

      TextWithIcon {
        text: "Shutdown"
        icon: "image://icon/system-shutdown-symbolic"
        clickable: true
        onClicked: {
          Quickshell.execDetached(["poweroff"])
        }
      }
    }
  }
}
