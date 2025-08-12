import QtQuick
import QtQuick.Layouts
import Quickshell
import "components"

// Top Bar
Scope {
  id: root

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: bar
      required property var modelData
      screen: modelData
      color: Qt.rgba(1, 1, 1, 0.25)

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: 30

      // Left
      RowLayout {
        id: leftLayout
        anchors {
          left: parent.left
          margins: 10
          verticalCenter: parent.verticalCenter
        }
        spacing: 5

        ArchLinux {}
        ActiveWindow {}
      }

      // Center
      RowLayout {
        id: centerLayout
        anchors.centerIn: parent

        Clock {}
      }

      // Right
      RowLayout {
        id: rightLayout
        anchors {
          right: parent.right
          margins: 10
          verticalCenter: parent.verticalCenter
        }
        spacing: 5

        SysTray {}
        Text { text: "|" }
        Volume {}
        Text { text: "|" }
        Battery {}
        Text { text: "|" }
        Notifications {}
      }
    }
  }
}
