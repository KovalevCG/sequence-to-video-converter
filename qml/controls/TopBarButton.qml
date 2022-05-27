import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: btnTopBar
    // Custom Properties

    property url btnIconSource: "../../images/svg_images/minimize_icon.svg"
    property color btnColorDefault: "#1c1d20"
    property color btnColorMouseOver: "#23272E"
    property color btnColorClicked: "#00a1f1"


    QtObject {
        id: internal
        // MouseOver and MouseClicked color change
        property var dinamicColor: if(btnTopBar.down){
                                       //dinamicColor = btnColorClicked
                                       btnTopBar.down ? btnColorClicked : btnColorDefault
                                   } else {
                                       btnTopBar.hovered ? btnColorMouseOver: btnColorDefault
                                   }

    }
    width: 35
    height: 35
    implicitWidth: 35
    implicitHeight: 35
    background: Rectangle {
        id:bgBtn
        color: internal.dinamicColor


        Image {
            id: iconBtn
            source: btnIconSource
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 16
            width: 16
            fillMode: Image.Image.PreserveAspectFit
            visible: false
        }
        ColorOverlay {
            anchors.fill: iconBtn
            source: iconBtn
            color: "#ffffff"
            antialiasing: false
        }
    }

}


