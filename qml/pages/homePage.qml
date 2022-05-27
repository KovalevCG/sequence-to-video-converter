import QtQuick 2.15
import QtQuick.Controls 2.15
import "../controls"
//import "../.."
import QtQuick.Layouts 1.11


Item {
    width: 545
    Rectangle {
        id: rectangle
        color: "#2c313c"
        anchors.fill: parent
        Rectangle {
            id: rectangle1
            height: 120
            color: "#3a4150"
            radius: 20
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 20
            anchors.leftMargin: 20
            anchors.topMargin: 10
            GridLayout {
                id: gridLayout
                anchors.fill: parent
                anchors.bottomMargin: 10
                anchors.topMargin: 10
                anchors.rightMargin: 20
                anchors.leftMargin: 20
                width: 100
                height: 100
                rows: 2
                columns: 2
                Label {
                    id: label
                    opacity: 0.9
                    color: "#ffffff"
                    text: qsTr("Sequence:")
                    font.pointSize: 10
                }
                Item {
                    id: item1
                    Layout.fillWidth: true
                    Layout.preferredWidth: 0
                    Layout.preferredHeight: 30
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Rectangle {
                        id: rectangle2
                        color: "#1d2027"
                        radius: 15
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        clip: true
                        anchors.topMargin: 1
                        anchors.leftMargin: 20
                        anchors.bottomMargin: -1
                        anchors.rightMargin: 0
                        Layout.leftMargin: 20
                        Layout.rowSpan: 1
                        Layout.preferredHeight: 30
                        Layout.preferredWidth: 0
                        Layout.fillHeight: false
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                        Label {
                            id: labelSequence
                            opacity: 0.6
                            color: "#ffffff"
                            //text: qsTr("filename????.png")
                            text: mainWindow.sequence_mask
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            font.weight: Font.Bold
                            anchors.leftMargin: 15
                            font.pointSize: 10
                        }
                    }
                    OpenBtn {
                        id: openBtnSequence
                        anchors.right: parent.right
                        anchors.top: rectangle2.top
                        anchors.topMargin: 0
                        onClicked: {}
                    }
                }
                Label {
                    id: label2
                    opacity: 0.9
                    color: "#ffffff"
                    text: qsTr("Output Filename:")
                    font.pointSize: 10
                }
                Item {
                    id: item2
                    Layout.leftMargin: 20
                    Layout.fillWidth: true
                    Layout.preferredWidth: 0
                    Layout.preferredHeight: 30
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Rectangle {
                        id: rectangleNoRound
                        width: rectangle4.width/2
                        height: 30
                        color: "#1d2027"
                        anchors.right: rectangle5.left
                        anchors.rightMargin: 5
                        Layout.rowSpan: 1
                        Layout.preferredHeight: 30
                        Layout.preferredWidth: 0
                        Layout.fillHeight: false
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    }
                    Rectangle {
                        id: rectangle4
                        height: 30
                        color: "#1d2027"
                        radius: 15
                        anchors.left: parent.left
                        anchors.right: rectangle5.left
                        clip: true
                        anchors.leftMargin: 0
                        anchors.rightMargin: 5
                        Layout.rowSpan: 1
                        Layout.preferredHeight: 30
                        Layout.preferredWidth: 0
                        Layout.fillHeight: false
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                        TextInput {
                            id: labelOutputFilename
                            opacity: 0.6
                            visible: true
                            color: "#ffffff"
                            text: mainWindow.output_file_name
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            font.weight: Font.Bold
                            clip: true
                            anchors.leftMargin: 15
                            font.pointSize: 10
                            activeFocusOnPress : true
                            selectByMouse : true
                            selectedTextColor : "white"
                            selectionColor : "gray"
                            onAccepted: { focus = false }
                        }
                    }

                    Rectangle {
                        id: rectangleNoCorner
                        width: rectangle5.width/2
                        height: 30
                        color: "#1d2027"
                        anchors.left: rectangle4.right
                        anchors.leftMargin: 5
                        Layout.rowSpan: 1
                        Layout.preferredHeight: 30
                        Layout.preferredWidth: 0
                        Layout.fillHeight: false
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    }
                    Rectangle {
                        id: rectangle5
                        width: 60
                        height: 30
                        color: "#1d2027"
                        radius: 15
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        Layout.rowSpan: 1
                        Layout.preferredHeight: 30
                        Layout.preferredWidth: 0
                        Layout.fillHeight: false
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                        Label {
                            id: labelOutputFileextension
                            opacity: 0.6
                            visible: true
                            color: "#ffffff"
                            text: mainWindow.output_file_name == '' ? '' : myComboBoxFormat.currentText.toLowerCase()
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.weight: Font.Bold
                            font.pointSize: 10
                        }
                    }
                }
            }
        }
        HugeBtn {
            id: btnConvert
            height: 60
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: rectangle1.bottom
            anchors.rightMargin: 20
            anchors.leftMargin: 20
            anchors.topMargin: 20
            onClicked: {
                backend.ui_values(textInputFPS.text,
                                  myComboBoxFormat.currentIndex,
                                  switchAlpha.checked,
                                  myComboBoxQuality.currentIndex,
                                  myComboBoxBitrate.currentIndex,
                                  switchRemove.checked,
                                  mainWindow.change_output,
                                  mainWindow.output_path)
                backend.convert()
            }
        }
        Rectangle {
            id: rectangleSettings
            //height: mySwitchSettings.checked ? 200 : 40
            //height: mainWindow.settingsChecked ? 200 : 40
            //height: 40
            height: 200
            color: "#3a4150"
            radius: 20
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: btnConvert.bottom
            clip: true
            anchors.rightMargin: 20
            anchors.leftMargin: 20
            anchors.topMargin: 20
            Rectangle {
                id: rectangleSettingsInside
                height: 30
                color: "#1d2027"
                radius: 20
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 5
                anchors.leftMargin: 5
                anchors.topMargin: 5
                MySwitch {
                    id: mySwitchSettings
                    switch_darkBg: "black"
                    ToolTip.delay: mainWindow.tooltip_delay
                    ToolTip.timeout: mainWindow.tooltip_timeout
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("Hide/Show settings")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: -10
                    anchors.topMargin: 0
                    scale: 0.8
                    checked: false
                    enabled: true
                    onClicked: {animMain.running = true; animationSettings.running = true}
                    //onPressed: {mySwitchSettings.checked ? mainWindow.settingsChecked = false : mainWindow.settingsChecked = true}
                }
                Label {
                    id: labelSettings
                    x: 205
                    y: -30
                    opacity: 0.9
                    color: "#ffffff"
                    text: qsTr("Settings")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pointSize: 12
                }
            }
            PropertyAnimation {
                id: animationSettings
                target: rectangleSettings
                property: "height"
                to: if (rectangleSettings.height == 200) return 40; else return 200;
                duration: if (rectangleSettings.height == 200) return 30; else return 300;
                easing.type: Easing.InOutQuint
            }
//            PropertyAnimation {
//                id: animationSettings
//                target: rectangleSettings
//                property: "height"
//                //to: if (mySwitchSettings.checked == false) return 40; else return 200;
//                to: mySwitchSettings.checked ? 200 : 40
//                duration: if (rectangleSettings.height == 200) return 30; else return 300;
//                easing.type: Easing.InOutQuint
//            }
            GridLayout {
                id: gridLayout1
                height: 100
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: rectangleSettingsInside.bottom
                columnSpacing: 25
                rows: 3
                columns: 2
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                Rectangle {
                    id: rectangleSet01
                    width: 200
                    height: 200
                    visible: true
                    color: "#00000000"
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Label {
                        id: labelFPS
                        color: "#ffffff"
                        text: qsTr("FPS:")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 10
                        ToolTip.text: qsTr("Frame rate")
                        ToolTip.delay: mainWindow.tooltip_delay
                        ToolTip.timeout: mainWindow.tooltip_timeout
                        ToolTip.visible: ToolTip.text ? maFPS.containsMouse : false
                        MouseArea {
                            id: maFPS
                            anchors.fill: parent
                            hoverEnabled: true
                        }
                    }
                    Rectangle {
                        id: rectangleFPS
                        width: 40
                        height: 30
                        color: "#1d2027"
                        radius: 10
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        Layout.rowSpan: 1
                        Layout.preferredHeight: 30
                        Layout.preferredWidth: 0
                        Layout.fillHeight: false
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                        TextInput {
                            id: textInputFPS
                            width: 30
                            opacity: 0.8
                            visible: true
                            color: "#ffffff"
                            text: mainWindow.fps
                            anchors.verticalCenter: parent.verticalCenter
                            horizontalAlignment: Text.AlignHCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            clip: true
                            font.pointSize: 10
                            activeFocusOnPress : true
                            selectByMouse : true
                            selectedTextColor : "white"
                            selectionColor : "gray"
                            onAccepted: { focus = false }

                        }
                    }
                }
                Rectangle {
                    id: rectangleSet02
                    width: 200
                    height: 200
                    color: "#00000000"
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Label {
                        id: labelQuality
                        color: "#ffffff"
                        text: qsTr("Quality:")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 10
                        ToolTip.text: qsTr("Output video quality")
                        ToolTip.delay: mainWindow.tooltip_delay
                        ToolTip.timeout: mainWindow.tooltip_timeout
                        ToolTip.visible: ToolTip.text ? maQuality.containsMouse : false
                        MouseArea {
                            id: maQuality
                            anchors.fill: parent
                            hoverEnabled: true
                        }
                    }
                    MyComboBox {
                        id: myComboBoxQuality
                        model: ["High", "Auto", "Low"]
                        editable: false
                        width: 90
                        height: 30
                        currentIndex: mainWindow.quality
                    }
                }

                Rectangle {
                    id: rectangleSet03
                    width: 200
                    height: 200
                    color: "#00000000"
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Label {
                        id: labelFormat
                        color: "#ffffff"
                        text: qsTr("Format:")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 10
                        ToolTip.text: qsTr("Output video format")
                        ToolTip.delay: mainWindow.tooltip_delay
                        ToolTip.timeout: mainWindow.tooltip_timeout
                        ToolTip.visible: ToolTip.text ? maFormat.containsMouse : false
                        MouseArea {
                            id: maFormat
                            anchors.fill: parent
                            hoverEnabled: true
                        }
                    }
                    MyComboBox {
                        id: myComboBoxFormat
                        model: ["MP4", "MOV", "MKV", "AVI", "GIF"]
                        width: 80
                        height: 30
                        currentIndex: mainWindow.format
                    }
                }

                Rectangle {
                    id: rectangleSet04
                    width: 200
                    height: 200
                    color: "#00000000"
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Label {
                        id: labelBitrate
                        color: "#ffffff"
                        text: qsTr("Bitrate(Mbps):")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 10
                        ToolTip.text: qsTr("Output video bit rate")
                        ToolTip.delay: mainWindow.tooltip_delay
                        ToolTip.timeout: mainWindow.tooltip_timeout
                        ToolTip.visible: ToolTip.text ? maBitrate.containsMouse : false
                        MouseArea {
                            id: maBitrate
                            anchors.fill: parent
                            hoverEnabled: true
                        }
                    }
                    MyComboBox {
                        id: myComboBoxBitrate
                        model: ["Auto", "1000", "2000", "4000", "8000", "20000"]
                        editable: false
                        width: 90
                        height: 30
                        currentIndex: mainWindow.bitrate
                    }
                }

                Rectangle {
                    id: rectangleSet05
                    width: 200
                    height: 200
                    color: "#00000000"
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Label {

                        id: labelAlpha
                        color: "#ffffff"
                        text: qsTr("Separate Alpha:")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 10
                        ToolTip.text: qsTr("If the sequence images contain an Alpha channel, it will be placed in a separate video")
                        ToolTip.delay: mainWindow.tooltip_delay
                        ToolTip.timeout: mainWindow.tooltip_timeout
                        ToolTip.visible: ToolTip.text ? maAlpha.containsMouse : false
                        MouseArea {
                            id: maAlpha
                            anchors.fill: parent
                            hoverEnabled: true
                        }
                    }
                    MySwitch {
                        id: switchAlpha
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: -10
                        enabled: true
                        checked: mainWindow.alpha
                        scale: 0.8
                        palette.dark: "white"
                        palette.midlight: "black"
                    }



                }

                Rectangle {
                    id: rectangleSet06
                    width: 200
                    height: 200
                    color: "#00000000"
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Label {
                        id: labelRemove
                        color: "#ffffff"
                        text: qsTr("Remove Files:")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 10
                        ToolTip.text: qsTr("Delete sequence files after converting sequence to video")
                        ToolTip.delay: mainWindow.tooltip_delay
                        ToolTip.timeout: mainWindow.tooltip_timeout
                        ToolTip.visible: ToolTip.text ? maRemove.containsMouse : false
                        MouseArea {
                            id: maRemove
                            anchors.fill: parent
                            hoverEnabled: true
                        }
                        //
                    }
                    MySwitch {
                        id: switchRemove
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: -10
                        enabled: true
                        checked: mainWindow.remove
                        scale: 0.8
                        palette.dark: "white"
                        palette.midlight: "black"
                    }
                }
            }
            HugeBtn {
                id: hugeBtnSave
                ToolTip.delay: 1500
                ToolTip.timeout: 5000
                ToolTip.visible: hovered
                ToolTip.text:  qsTr("Save the current settings as default")
                text: "SAVE SETTINGS"
                palette.buttonText: "#eeeeee"
                height: 30
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: gridLayout1.bottom
                font.pointSize: 12
                anchors.rightMargin: 10
                anchors.leftMargin: 10
                anchors.topMargin: 15
                onClicked: {backend.ui_values(textInputFPS.text,
                                              myComboBoxFormat.currentIndex,
                                              switchAlpha.checked,
                                              myComboBoxQuality.currentIndex,
                                              myComboBoxBitrate.currentIndex,
                                              switchRemove.checked,
                                              mainWindow.change_output,
                                              mainWindow.output_path)
                            backend.save_settings_file()
                }

            }



        }

    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}
}
##^##*/
