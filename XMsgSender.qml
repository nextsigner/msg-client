import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    id: r
    width: parent.width
    height: app.fs*3
    border.width: 2
    border.color: 'red'
    signal send(string msg)
    Row{
        spacing: app.fs
        Rectangle {
            width: r.width-btnSend.width-parent.spacing
            height: app.fs*3
            border.width: 2
            border.color: 'red'
            TextEdit{
                id: txt
                width: parent.width-app.fs
                height: parent.height-app.fs
                anchors.centerIn: parent
            }
        }
        Button{
            id: btnSend
            text: 'Enviar'
            onClicked: {
                unik.speak(' dice '+txt.text)
                r.send(txt.text)
            }
        }
    }
}
