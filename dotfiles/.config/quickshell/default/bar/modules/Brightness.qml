import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import "root:/components"

TextWithIcon {
  id: root
  text: brightness + "%"
  icon: "image://icon/" + getIcon()
  clickable: true
  onClicked: configWindow.visible = !configWindow.visible

  property var brightness

  Process {
    id: process
    running: true
    command: [ "brightnessctl", "get"]
    stdout: StdioCollector {
      onStreamFinished: {
        var output = this.text.replace("\n", "")
        if (root.brightness != output) {
          root.brightness = output
        }
      }
    }
  }

  Timer {
    interval: 50
    running: true
    repeat: true
    onTriggered: process.running = true
  }

  function getIcon() {
    if (brightness == 0) {
      return "display-brightness-off-symbolic"
    } else if (0 < brightness <= 0.3) {
      return "display-brightness-low-symbolic"
    } else if (0.3 < brightness <= 0.7) {
      return "display-brightness-medium-symbolic"
    } else {
      return "display-brightness-high-symbolic"
    }
  }

  PopupWindow {
    id: configWindow
    property var window: root.QsWindow.window
    anchor.window: window
    anchor.onAnchoring: {
      const rect = window.mapFromItem(root, -(configWindow.implicitWidth - root.implicitWidth)/2, window.height);
      configWindow.anchor.rect = rect;
    }
    color: "transparent"
    implicitWidth: slider.implicitWidth + 12

    Rectangle {
      anchors.fill: parent
      color: Style.style.backgroundSolid
      radius: 12
    }

    MyText {
      id: configTitle
      anchors {
        top: parent.top
        left: parent.left
        margins: 12
      }
      text: "<b>Brightness</b>"
    }

    MySlider {
      id: slider
      icon: "image://icon/" + getIcon()
      from: 0
      to: 100
      value: brightness
      anchors {
        top: configTitle.bottom
        left: configTitle.left
      }
      onMoved: {
        if (slider.value == 0) {
          slider.value = 1
        }
        Quickshell.execDetached(["brightnessctl", "set", slider.value])
      }
    }
  }

  onBrightnessChanged: {
    popup.visible = true
    timer.start()
  }

  Timer {
    id: timer
    interval: 1000
    onTriggered: popup.visible = false
  }

  PopupWindow {
    id: popup
    property var window: root.QsWindow.window
    property var monitor: Hyprland.focusedMonitor
    anchor {
      window: window
      rect.x: (monitor.width/monitor.scale - popup.width) / 2
      rect.y: monitor.height/monitor.scale - popup.height - 100
    }
    color: "transparent"
    implicitHeight: popupText.implicitHeight + 12
    implicitWidth: popupText.implicitWidth + 12

    Rectangle {
      id: background
      anchors.fill: parent
      color: Style.style.backgroundSolid
      radius: 12
    }

    TextWithIcon {
      id: popupText
      anchors.centerIn: parent
      icon: "image://icon/" + getIcon()
      text: "<h2>" + brightness + "%</h2>"
    }
  }
}
