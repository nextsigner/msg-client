import QtQuick 2.7
import QtQuick.Controls 2.0

ApplicationWindow{
	id: app
	visible: true
	visibility: "Maximized"
	color: 'red'
    property string moduleName: 'msg-client'

    Item{
        id: xApp
        anchors.fill: parent
    }

    Component.onCompleted: {
        unik.speak('Se ha iniciado '+app.moduleName)
    }
}
