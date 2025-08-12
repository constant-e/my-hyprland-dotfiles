import QtQuick

Item {
  id: root
  implicitHeight: icon.height
  implicitWidth: icon.width

  Image {
    id: icon
    anchors.centerIn: parent
    height: 20
    width: 20
    source: "image://icon/distributor-logo-archlinux"
  }

  MouseArea {
    id: area
    anchors.fill: parent
    onClicked: event => {
      
    }
  }
}
