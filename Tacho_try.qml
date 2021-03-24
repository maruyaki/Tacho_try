import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.0
import QtQuick.Scene2D 2.9

Window {
    width: 800
    height: 600
    visible: true
    color: "#3a3838"
    title: qsTr("taco")


    RoundButton {
        id: roundButton
        x: Window.width / 3 - Window.height * 0.35
        y: Window.height / 2 - Window.height * 0.35
        width: Window.height * 0.7
        height: Window.height * 0.7
        text: "+"
    }

    Rectangle {
        id: rectTacho
        x: Window.width / 3
        y: Window.height / 2
        width: 5
        height: Window.height * 0.3
        color: "#ff0000"

        transform: Rotation{
            origin.x: rectTacho.width /2
            origin.y: 0
            axis {x: 0; y: 0; z: 1}
            angle: 360 * txtRpm.text / 130000
        }
    }

    Text {
        id: txtRpm
        x: rectTacho.height / 2 + rectTacho.x
        y: rectTacho.height / 4 + rectTacho.y
        color: "#000000"
        text: qsTr("4500")
        font.pixelSize: 40
        horizontalAlignment: Text.AlignRight
        font.bold: true
    }


    Timer {
        interval: 500; running: true; repeat: true
        onTriggered: txtRpm.text = Connect.rpm()
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/
