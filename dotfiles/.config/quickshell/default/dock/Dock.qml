import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import "root:/components"

// Dock
Scope {
  id: root

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: dock
      required property var modelData
      screen: modelData
      color: "transparent"
      WlrLayershell.layer: WlrLayer.Overlay
      // To avoid blur which has no rounded corners
      WlrLayershell.namespace: "quickshell:dock"
      visible: false

      GlobalShortcut {
        name: "dock"
        onPressed: {
          if (!dock.visible && dockModel.values.length == 0) {
            return;
          } else {
            dock.visible = !dock.visible;
          }
        }
      }

      anchors {
        bottom: true
      }

      exclusiveZone: 0

      implicitHeight: 82
      implicitWidth: layout.implicitWidth + 34

      Rectangle {
        id: background
        anchors {
          fill: parent
          margins: 5
        }

        color: Style.style.backgroundSolid
        radius: 12
      }

      RowLayout {
        id: layout
        spacing: 12
        anchors {
          centerIn: parent
          margins: 12
        }
        Repeater {
          model: dockModel
          DockItem {
            required property var modelData
            app: modelData
          }
        }
      }

      ScriptModel {
        id: dockModel
        values: {
          var map = new Map();

          // TODO: add pinned apps

          for (const toplevel of ToplevelManager.toplevels.values) {
            if (!map.has(toplevel.appId)) {
              map.set(toplevel.appId, []);
            }
            map.get(toplevel.appId).push(toplevel);
          }

          var value = [];
          for (const [appId, toplevels] of map) {
            value.push({ appId: appId, toplevels: toplevels });
          }

          return value;
        }
      }
    }
  }
}
