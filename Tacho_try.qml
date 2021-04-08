import QtQuick 2.11
import QtQuick.Window 2.11


Window {
    width: 800
    height: 480
    visible: true
    color: "#000000"
    title: qsTr("taco")


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
            angle: 360 * txtRpm.text / 13000
        }
    }

    Text {
        id: txtRpm
        x: rectTacho.height / 2 + rectTacho.x
        y: rectTacho.height / 4 + rectTacho.y
        color: "#ffffff"
        text: qsTr("4500")
        font.pixelSize: 40
        horizontalAlignment: Text.AlignRight
        font.bold: true
    }


    Timer {
        interval: 500; running: true; repeat: true
        onTriggered: txtRpm.text = Connect.rpm()
    }

    Text {
        id: text1
        x: 530
        y: 340
        width: 200
        height: 60
        color: "#ffffff"
        text: qsTr("Text")
        font.pixelSize: 40
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Text {
        id: text2
        x: 530
        y: 70
        width: 200
        height: 175
        color: "#ffffff"
        text: qsTr("1")
        font.pixelSize: 150
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        fontSizeMode: Text.HorizontalFit
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/
