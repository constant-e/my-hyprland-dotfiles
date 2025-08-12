import QtQuick
import Quickshell.Hyprland
import Quickshell.Wayland

Item {
  id: root
  readonly property Toplevel activeWindow: ToplevelManager.activeToplevel
  readonly property HyprlandWorkspace activeWorkspace: Hyprland.focusedWorkspace

  Text {
    anchors {
      left: parent.left
      verticalCenter: parent.verticalCenter
    }

    text: (root.activeWindow?.appId ?? "Hyprland") + " | Workspace " + root.activeWorkspace.name
  }
}
