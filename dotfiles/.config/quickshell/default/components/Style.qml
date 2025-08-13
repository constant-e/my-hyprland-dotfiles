pragma Singleton

import QtQuick
import Quickshell

Singleton {
    property QtObject style
    property bool dark: true

    style : QtObject {
        // HEX in qml is AARRGGBB
        property color background: dark ? "#7f222226" : "#7fffffff"
        property color foreground: dark ? "white" : "black"
    }
}

