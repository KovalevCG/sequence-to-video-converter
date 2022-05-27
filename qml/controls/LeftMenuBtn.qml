import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: btnLeftMenu
    text: qsTr("Hello!")
    // Custom Properties

    property url btnIconSource: "../../images/svg_images/home_icon.svg"
    property color btnColorDefault: "#1c1d20"
    property color btnColorMouseOver: "#23272E"
    property color btnColorClicked: "#00a1f1"
    property int iconWidth: 18
    property int iconHeight: 18
    property color activeMenuColorLeft: "#55aaff"
    property color activeMenuColorRight: "#2c313c"
    property bool isActiveMenu: false

    QtObject {
        id: internal
        // MouseOver and MouseClicked color change
        property var dinamicColor: if(btnLeftMenu.down){
                                       //dinamicColor = btnColorClicked
                                       btnLeftMenu.down ? btnColorClicked : btnColorDefault
                                   } else {
                                       btnLeftMenu.hovered ? btnColorMouseOver: btnColorDefault
                                   }
    }

//    width: 250
//    height: 40
    implicitWidth: 250
    implicitHeight: 60
    background: Rectangle {
        id:bgBtn
        color: internal.dinamicColor
        Rectangle {
            //id: bgBtnSel
            //anchors.right: parent.right
            //anchors.top: parent.top
            //anchors.bottom: parent.bottom
            anchors.fill: parent
            //border.color: "#000000"
            //border.width: 0
            //width: 5
            visible: isActiveMenu
            color: "#282a30"
        }
        Rectangle {
            //id: bgBtnSel
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            color: activeMenuColorLeft
            width: 3
            visible: isActiveMenu
        }
        Rectangle {
            //id: bgBtnSel
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            color: activeMenuColorRight
            border.color: "#000000"
            border.width: 0
            width: 5
            visible: isActiveMenu
        }

    }
    contentItem: Item {
        id: content
        //anchors.fill: parent
        Image {
            id: iconBtn
            source: btnIconSource
            anchors.leftMargin: 18
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            sourceSize.width: iconWidth
            sourceSize.height: iconHeight
            width: iconWidth
            height: iconHeight

            fillMode: Image.Image.PreserveAspectFit
            visible: false
            antialiasing: true
        }
        ColorOverlay {
            anchors.fill: iconBtn
            source: iconBtn
            color: "#ffffff"
            antialiasing: true
            width: iconWidth
            height: iconHeight
        }
        Text {
            color: "#ffffff"
            text: btnLeftMenu.text
            font: btnLeftMenu.font
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 75
        }
    }

}




/*##^##
Designer {
    D{i:0;height:60}
}
##^##*/
