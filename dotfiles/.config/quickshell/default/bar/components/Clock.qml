import QtQuick
import Quickshell

Item {
  Text {
    anchors.centerIn: parent
    text: Qt.formatDateTime(clock.date, "yyyy.MM.dd dddd hh:mm:ss")
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
