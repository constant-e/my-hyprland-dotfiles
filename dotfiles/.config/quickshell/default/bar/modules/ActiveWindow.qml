import QtQuick
import Quickshell.Hyprland
import Quickshell.Wayland
import "root:/components"

Item {
  id: root
  readonly property Toplevel activeWindow: ToplevelManager.activeToplevel
  readonly property HyprlandWorkspace activeWorkspace: Hyprland.focusedWorkspace

  MyText {
    anchors {
      left: parent.left
      verticalCenter: parent.verticalCenter
    }

    text: (root.activeWindow?.appId ?? "Hyprland") + " | Workspace " + root.activeWorkspace.name
  }
}
