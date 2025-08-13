import QtQuick.Layouts
import Quickshell
import "modules"
import "root:/components"

// Top Bar
Scope {
  id: root

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: bar
      required property var modelData
      screen: modelData
      color: Style.style.background

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
        MyText { text: "|" }
        Brightness {}
        MyText { text: "|" }
        Volume {}
        MyText { text: "|" }
        Battery {}
        MyText { text: "|" }
        Notifications {}
      }
    }
  }
}
