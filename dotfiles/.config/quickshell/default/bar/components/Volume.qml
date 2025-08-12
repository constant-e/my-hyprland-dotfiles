import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire

RowLayout {
  id: root
  property var sink: Pipewire.defaultAudioSink
  spacing: 5

  Image {
    Layout.maximumHeight: 20
    Layout.maximumWidth: 20
    source: "image://icon/" + getIcon()
    fillMode: Image.PreserveAspectFit
    
  }

  function getIcon() {
    if (sink.audio.volume == 0 || sink.audio.muted) {
      return "audio-volume-muted"
    } else if (0 < sink.audio.volume <= 0.3) {
      return "audio-volume-low"
    } else if (0.3 < sink.audio.volume <= 0.7) {
      return "audio-volume-medium"
    } else {
      return "audio-volume-high"
    }
  }

  Text {
    id: volume
    text: sink.audio.muted ? "Muted" : Math.round(sink.audio.volume * 100) + "%"
  }

  PwObjectTracker {
    id: tracker
    objects: [sink]
  }
}
