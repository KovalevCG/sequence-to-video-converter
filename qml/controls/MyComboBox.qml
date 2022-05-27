import QtQuick 2.15
import QtQuick.Controls 2.15

ComboBox {
    id: myComboBox
    model: ["MP4", "MOV", "MKV", "AVI"]
    editable: false
    width: 80
    height: 30
    delegate: ItemDelegate {
        height: 30
        width: myComboBox.width
        //border: 0
        contentItem: Text {
            opacity: 0.9
            text: modelData
            color: "white"

            font: myComboBox.font
            verticalAlignment: Text.AlignVCenter
        }
        background: Rectangle {
            color: "#1d2027"
            //border: 0
        }
    }
    contentItem: Text {

        opacity: 0.9
        text: myComboBox.displayText
        font: myComboBox.font
        color: "white"
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    anchors.verticalCenter: parent.verticalCenter
    anchors.right: parent.right
    currentIndex: 0
    background: Rectangle {
        color: "#1d2027"
        radius: 10
    }
}
