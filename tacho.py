import sys
import os
import can
import time
import threading
from PySide2 import QtCore, QtWidgets, QtQml


bus = can.ThreadSafeBus(channel='can0', bustype='socketcan_native', bitrate=500000,can_filters=[{'can_id': 0x7e8, 'can_mask': 0x7e8}])


class Candata:
    rpm = 0

    def get_rpm(self):
        return self.rpm

    def set_rpm(self, arg):
        if not arg:
            return

        #print(arg.data[2])
        #ret = arg.split()
        #print(ret)

        #if ret[5] != '0C':
        #    return

        #self.rpm = int((int(ret[6], 16) * 256 + int(ret[7], 16)) / 4)
        
        if arg.arbitration_id != 0x7e8:
            return
        
        if arg.dlc < 3:
            return

        if arg.data[2] != 0x0c:
            return

        self.rpm = int((arg.data[3] * 256 + arg.data[4]) / 4)

        print(self.rpm)


candata = Candata()


class Connect(QtCore.QObject):
    def __init__(self, parent=None):
        super(Connect, self).__init__(parent)

    @QtCore.Slot(result=float)
    def rpm(self):
        return candata.get_rpm()


def canscan_worker():
    for msg in bus:
        print(msg)
        candata.set_rpm(msg)


def cansend_worker():
    while True:
        msg = can.Message(arbitration_id=0x7e0, is_extended_id=False, data=[0x02, 0x01, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x00])
        bus.send(msg)
        time.sleep(0.5)


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

    t1 = threading.Thread(target=canscan_worker)
    t2 = threading.Thread(target=cansend_worker)
    t1.start()
    t2.start()

    app.exec_()

#    for msg in bus:
#        candata.set_rpm(msg)

#    candata.set_rpm('can0 7E8    [8] 04 41 0C 0C 7D 00 00 00')

    #sys.exit(app.exec_())
