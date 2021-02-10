import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.2
import QtQuick.Window 2.0
import Qt.labs.settings 1.0
ApplicationWindow {
    id: app
    visible: true
    width: Qt.platform.os!=='android'?Screen.width/2:Screen.width
    height: Qt.platform.os!=='android'?Screen.desktopAvailableHeight-altoBarra:Screen.desktopAvailableHeight
    x:Screen.width/2
    title: qsTr("Msg-Client by nextsigner")
    visibility: 'Windowed'
    color: 'black'
    property string moduleName: 'msg-client'
    property int altoBarra: 0

    property int fs: appSettings.fs

    property color c1: "#62DA06"
    property color c2: "#8DF73B"
    property color c3: "black"
    property color c4: "white"

    Settings{
        id: appSettings
        fileName: app.moduleName+'.cfg'
        category: 'conf-'+app.moduleName
        property int cantRun
        property bool fullScreen
        property bool logViewVisible

        property int fs

        property string url: 'ws://192.168.1.48:5500'
        property string user: ''

        property real visibility
    }
    FontLoader {name: "FontAwesome";source: "qrc:/fontawesome-webfont.ttf";}
    Item{
        id: xApp
        anchors.fill: parent
        Column{
            XMsgList{
                id: xMsgList
                width: xApp.width
                height: xApp.height-xMsgSender.height
                //wsSqlClient.sendCode(code)
            }
            XMsgSender{
                id: xMsgSender
                onSend: wsSqlClient.sendCode(msg)
            }
        }
        WsSqlClient{
            id:wsSqlClient
            sqliteFileName: app.moduleName+'.sqlite'
            onSucess: xMsgList.updateList()
            onLoguinSucess: {
                focus=false
                visible=false
                //unikTextEditor.visible=true
                //unikTextEditor.textEditor.focus=true
                //unikTextEditor.textEditor.setPos()
            }
            onErrorSucess: {
                console.log('WebSockets Error success...')
                focus=true
                visible=true
                //unikTextEditor.visible=false
                //unikTextEditor.textEditor.focus=false
            }
            onVisibleChanged: {
                if(!visible){
                    focus=false
                }else{
                    //unikTextEditor.visible=true
                }
            }
        }
        Button{
            text: 'Conectar'
            font.pixelSize: r.fs
            anchors.right: parent.right
            onClicked: {
               wsSqlClient.loguin()
            }
        }
        }
    UnikBusy{id:ub;running: false}
    Shortcut {
        sequence: "Shift+Left"
        onActivated: {

        }
    }
    Shortcut {
        sequence: "Shift+Return"
        onActivated: {
            if(app.visibility!==Window.Maximized){
                app.visibility='Maximized'
            }else{
                app.visibility='Windowed'
            }
        }
    }
    Shortcut {
        sequence: "Ctrl+Shift+q"
        onActivated: {
            Qt.quit()
        }
    }
    onVisibilityChanged: {
        appSettings.visibility=app.visibility
    }
    Component.onCompleted: {
        var ukldata='-folder='+appsDir+'/'+app.moduleName+' -cfg'
        var ukl=appsDir+'/link_'+app.moduleName+'.ukl'
        unik.setFile(ukl, ukldata)
        if(appSettings.lvh<=0){
            appSettings.lvh=100
        }
        if(appSettings.fs<=0){
            appSettings.fs=20
        }
        appSettings.logViewVisible=true
    }
}

