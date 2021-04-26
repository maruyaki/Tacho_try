import QtQuick 2.11
import QtQuick.Window 2.11


Window {
	width: 800
	height: 480
	visible: true
	visibility: "FullScreen"
	title: qsTr("taco")

	Rectangle {
		width: 800
		height: 480
		color: "black"
			
		Rectangle {
	       		id: rectTacho
	        	x: Window.width / 3
	        	y: Window.height / 2
	        	width: 5
	        	height: Window.height * 0.4
	        	color: "red"

		        transform: Rotation {
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
	        	color: "white"
	        	text: qsTr("0")
	        	font.pixelSize: 40
	        	horizontalAlignment: Text.AlignRight
	        	font.bold: true
	    	}


	    	Timer {
	        	interval: 100; running: true; repeat: true
	        	onTriggered: {
	            		txtRpm.text = Connect.rpm();
	            		txtSpeed.text = Connect.speed();
	            		txtGear.text = Connect.gear();
	        	}
	    	}


		Text {
	        	id: txtSpeed
	        	x: 530
	        	y: 340
	        	width: 200
	        	height: 60
	        	color: "white"
	        	text: qsTr("0")
	        	font.pixelSize: 40
	        	horizontalAlignment: Text.AlignHCenter
	        	verticalAlignment: Text.AlignVCenter
	    	}

	    	Text {
	        	id: txtGear
	        	x: 530
	        	y: 70
	        	width: 200
	        	height: 175
	        	color: "white"
	        	text: qsTr("1")
	        	font.pixelSize: 150
	        	horizontalAlignment: Text.AlignHCenter
	        	verticalAlignment: Text.AlignVCenter
	        	fontSizeMode: Text.HorizontalFit
	    	}


	    	MouseArea {
	        	anchors.fill: parent
	        	cursorShape: Qt.BlankCursor
	        	onClicked: {
				if (parent.color.r === 0) {
					parent.color = "white";
					txtRpm.color = "black";
					txtSpeed.color = "black";
					txtGear.color = "black";
				} else {
					parent.color = "black";
					txtRpm.color = "white";
					txtSpeed.color = "white";
                                        txtGear.color = "white";
				}
			}
	    	}
	}
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/
