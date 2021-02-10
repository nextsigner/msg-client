import QtQuick 2.0

Item {
    id: r
//    Rectangle{
//        anchors.fill: r
//        color: 'blue'
//        border.width: 3
//        border.color: 'green'
//    }
    ListView{
        id: lv
        spacing: app.fs
        width: r.width
        height: r.height//-app.fs*3
        model: lm
        delegate: compMsg
    }
    ListModel{
        id: lm
        function addMsg(from, msg, ms){
            return{
                f: from,
                m: msg,
                t:ms
            }
        }
    }
    Component{
        id: compMsg
        Rectangle{
            id: xMsg
            width: r.width-app.fs*0.2
            height: colMsg.height+app.fs*2
            border.width: 1
            //border.color: 'red'
            radius: app.fs*0.25
            anchors.horizontalCenter: parent.horizontalCenter
            Column{
                id: colMsg
                spacing: app.fs*0.5
                anchors.centerIn: parent
                Text {
                    id: txtTime
                    font.pixelSize: app.fs*0.5
                    wrapMode: Text.WordWrap
                }
                Text {
                    id: txtMsg
                    //text: '<b>'+f+'</b>: '+m
                    font.pixelSize: app.fs
                    width: xMsg.width-app.fs*2
                    //anchors.centerIn: parent
                    wrapMode: Text.WordWrap
                }
            }
            Component.onCompleted: {
                let d = new Date(parseInt(t))
                txtTime.text=''+d.toString()
                txtMsg.text='<b>'+f+'</b>: '+m
            }
        }
    }
    property int uId: 0
    function updateList(){
        let sql='SELECT * FROM  msgs where id > '+r.uId
        let rows=unik.getSqlData(sql)
        for(var i=0;i<rows.length;i++){
            r.uId=parseInt(rows[i].col[0])
            let from=rows[i].col[1]
            let msg=rows[i].col[2]
            let ms=rows[i].col[3]
            addMsg(from, msg, ms)
            //console.log()
        }
    }
    function addMsg(from, msg, ms){
        lm.append(lm.addMsg(from, msg, ms))
        lv.currentIndex=lv.count
    }
}
