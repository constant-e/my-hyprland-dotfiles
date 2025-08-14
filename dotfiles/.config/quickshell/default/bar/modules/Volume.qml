import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import "root:/components"

TextWithIcon {
  id: root
  icon: "image://icon/" + getSinkIcon()
  text: sinkMuted ? "Muted" : Math.round(sinkVolume * 100) + "%"
  clickable: true
  onClicked: configWindow.visible = !configWindow.visible

  property var sink: Pipewire.defaultAudioSink
  property var source: Pipewire.defaultAudioSource
  property var sinkVolume: sink.audio.volume
  property var sourceVolume: source.audio.volume
  property var sinkMuted: sink.audio.muted
  property var sourceMuted: source.audio.muted

  function getSinkIcon() {
    if (sinkVolume == 0 || sinkMuted) {
      return "audio-volume-muted"
    } else if (0 < sinkVolume <= 0.3) {
      return "audio-volume-low"
    } else if (0.3 < sinkVolume <= 0.7) {
      return "audio-volume-medium"
    } else {
      return "audio-volume-high"
    }
  }

  function getSourceIcon() {
    if (sourceVolume == 0 || sourceMuted) {
      return "audio-input-microphone-muted"
    } else if (0 < sourceVolume <= 0.3) {
      return "audio-input-microphone-low"
    } else if (0.3 < sourceVolume <= 0.7) {
      return "audio-input-microphone-medium"
    } else {
      return "audio-input-microphone-high"
    }
  }

  PwObjectTracker {
    objects: [sink, source]
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
    implicitWidth: Math.max(sinkSlider.implicitWidth, sourceSlider.implicitWidth) + 12

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
      text: "<b>Volume</b>"
    }

    MySlider {
      id: sinkSlider
      icon: "image://icon/" + getSinkIcon()
      from: 0
      to: 1
      value: sinkVolume
      anchors {
        top: configTitle.bottom
        left: configTitle.left
      }
      onMoved: {
        sinkVolume = sinkSlider.value
      }
    }

    MySlider {
      id: sourceSlider
      icon: "image://icon/" + getSourceIcon()
      from: 0
      to: 1
      value: sourceVolume
      anchors {
        left: configTitle.left
        top: sinkSlider.bottom
      }
      onMoved: {
        sourceVolume = sinkSlider.value
      }
    }
  }

  onSinkVolumeChanged: {
    if (!sinkMuted) {
      popup.visible = true
      timer.start()
    }
  }

  onSinkMutedChanged: {
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
      anchors.fill: parent
      color: Style.style.backgroundSolid
      radius: 12
    }

    TextWithIcon {
      id: popupText
      anchors.centerIn: parent
      icon: "image://icon/" + getSinkIcon()
      text: "<h2>" + (sinkMuted ? "Muted" : Math.round(sinkVolume * 100) + "%") + "</h2>"
    }
  }
}
