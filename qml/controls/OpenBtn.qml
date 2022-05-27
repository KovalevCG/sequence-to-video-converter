import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: btnOpen
    // Custom Properties

    property url btnIconSource: "../../images/svg_images/dots_icon.svg"
    property color btnColorDefault: mainWindow.brightBlueDesat
    property color btnColorMouseOver: "#3eb2ff"
    property color btnColorClicked: "#b7d6e6"


    QtObject {
        id: internal
        // MouseOver and MouseClicked color change
        property var dinamicColor: if(btnOpen.down){
                                       //dinamicColor = btnColorClicked
                                       btnOpen.down ? btnColorClicked : btnColorDefault
                                   } else {
                                       btnOpen.hovered ? btnColorMouseOver: btnColorDefault
                                   }
    }
    width: 40
    height: 30
    implicitWidth: 30
    implicitHeight: 30
    background: Rectangle {
        id: rectangle
        color: internal.dinamicColor
        radius: 100
        Rectangle {
            id:bgBtn
            color: internal.dinamicColor
            anchors.left: parent.left
            anchors.leftMargin: 0
            //radius: 100
            width: btnOpen.width/2
            height: btnOpen.height

        }
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


