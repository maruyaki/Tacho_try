import sys
import os
import can
from PySide2 import QtCore, QtWidgets, QtQml


bus = can.interface.Bus(channel='can0', bustype='socketcan_native', bitrate=500000,canfilters=None)


class Candata:
    rpm = 0

    def get_rpm(self):
        return self.rpm

    def set_rpm(self, arg):
        if not arg:
            return

        ret = arg.split()

        if ret[5] != '0C':
            return

        self.rpm = int((int(ret[6], 16) * 256 + int(ret[7], 16)) / 4)


candata = Candata()


class Connect(QtCore.QObject):
    def __init__(self, parent=None):
        super(Connect, self).__init__(parent)

    @QtCore.Slot(result=float)
    def rpm(self):
        return candata.get_rpm()


if __name__ == "__main__":
    os.environ["QT_QUICK_CONTROLS_STYLE"] = "Material"
    app = QtWidgets.QApplication(sys.argv)
    connect = Connect()
    engine = QtQml.QQmlApplicationEngine()
    ctx = engine.rootContext()
    ctx.setContextProperty("Connect", connect)
    engine.load('Tacho_try.qml')

    if not engine.rootObjects():
        sys.exit(-1)

    for msg in bus:
        candata.set_rpm(msg)

    #candata.set_rpm('can0 7E8    [8] 04 41 0C 0C 7D 00 00 00')

    sys.exit(app.exec_())