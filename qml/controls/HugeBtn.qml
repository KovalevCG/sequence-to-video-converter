import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: btnHuge
    text: qsTr("CONVERT")

    flat: false
    font.bold: true
    font.pointSize: 16
    palette.buttonText: "white"
    // Custom Properties

    property color btnColorDefault: "#55aaff"
    property color btnColorMouseOver: "#3eb2ff"
    property color btnColorClicked: "#b7d6e6"
    property color activeMenuColorLeft: "#55aaff"
    property color activeMenuColorRight: "#2c313c"


    QtObject {
        id: internal
        // MouseOver and MouseClicked color change
        property var dinamicColor: if(btnHuge.down){
                                       btnHuge.down ? btnColorClicked : btnColorDefault
                                   } else {
                                       btnHuge.hovered ? btnColorMouseOver: btnColorDefault
                                   }

    }

    implicitWidth: 250
    implicitHeight: 60
    background: Rectangle {
        id:bgBtn
        color: internal.dinamicColor
        radius: 20
    }


}


/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.6600000262260437;height:480;width:640}
}
##^##*/
