import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

RowLayout {
  id: root
  spacing: 5

  Repeater {
    model: SystemTray.items

    MouseArea {
      id: area
      required property SystemTrayItem modelData
      property SystemTrayItem item: modelData

      Layout.fillHeight: true
      implicitWidth: icon.implicitWidth + 5
      acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
      hoverEnabled: true

      onClicked: event => {
        switch (event.button) {
          case Qt.LeftButton:
            item.activate();
            break;
          case Qt.MiddleButton:
            item.secondaryActivate();
            break;
          case Qt.RightButton:
            if (item.hasMenu) menuAnchor.open();
            break;
        }
        event.accepted = true;
      }

      onWheel: event => {
        item.scroll(event.angleDelta.x, event.angleDelta.y)
      }

      IconImage {
        id: icon
        anchors.centerIn: parent
        source: area.item.icon
        implicitSize: 16
      }

      QsMenuAnchor {
        id: menuAnchor
        menu: area.item.menu
        property var window: area.QsWindow.window
        anchor.window: window
        anchor.onAnchoring: {
          const rect = window.mapFromItem(area, 0, area.y);
          menuAnchor.anchor.rect = rect;
        }
      }
    }
  }
}
