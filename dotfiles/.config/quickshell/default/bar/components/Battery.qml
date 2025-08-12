import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower

RowLayout {
  id: root
  // 5 + margin + width (battery icon)
  spacing: 8

  // Battery Icon
  Rectangle {
    color: "transparent"
    border.color: "black"
    border.width: 1
    implicitWidth: 20
    implicitHeight: 10
    radius: 3

    Rectangle {
      anchors {
        left: parent.left
        verticalCenter: parent.verticalCenter
        margins: 2
      }

      width: (parent.width - 4) * UPower.displayDevice.percentage
      height: parent.height - 4
      color: getColor()
      radius: 2
    }

    Rectangle {
      anchors {
        left: parent.right
        verticalCenter: parent.verticalCenter
        leftMargin: 1
      }
      height: 6
      width: 2
      color: "black"
      radius: 4
    }
  }

  function getColor() {
    switch (UPower.displayDevice.state) {
      case UPowerDeviceState.Charging: return Qt.rgba(52/255, 199/255, 89/255);
      case UPowerDeviceState.Discharging && UPower.displayDevice.percentage < 0.2: return "red";
      default: return "black";
    }
  }

  Text {
    id: battery

    text: UPower.displayDevice.percentage * 100 + "%"
    // AC and BAT, at least 2 devices
    visible: UPower.devices.values.length != 1
  }
}
