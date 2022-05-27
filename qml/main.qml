import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "controls"
import QtGraphicalEffects 1.15
import QtQuick.Dialogs 1.3


Window {
    id: mainWindow
    width: 640
    //height: settingsChecked ? 550 : 390
    height: 550
    visible: true
    color: "#00000000"
    title: "Sequence to Video"
    minimumWidth: 525
    minimumHeight: 300

    // Remove Title bar
    flags: Qt.Window | Qt.FramelessWindowHint

    // Properties
    property bool settingsChecked: false
    property bool windowMaximizedStatus: false
    property color bg: "#2c313c"
    property color darkBg: "#1d2027"
    property color brightBlue: "#55aaff"
    property color brightBlueDesat: "#7dbeff"
    
    // Default Values from Python    
    property string sequence_folder: "sequence_folder"
    property string sequence_mask: "sequence_file_name"
    property string output_file_name: "output_file_name"
    // -------
    property int fps: 22
    property int format: 0
    property bool alpha: false
    property int quality: 0
    property int bitrate: 0
    property bool remove: false
    property bool change_output: true
    property string output_path: "test"
    // -------
    property string bottom_info: "By Alexander Kovalev"
    
    // ToolTips
    property int tooltip_delay: 1500
    property int tooltip_timeout: 5000

    // Inernal functions

    Rectangle {
        id: bg
        color: "#2c313c"       
        border.color: "#383e4c"
        border.width: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.topMargin: 10

        Rectangle {
            id: appContainer            
            color: "#00000000"
            anchors.fill: parent
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            anchors.bottomMargin: 1
            anchors.topMargin: 1

            Rectangle {
                id: topBar
                height: 60                
                color: "#1c1d20"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0

                ToggleButton {
                    onClicked: animationMenu.running = true
                }

                Rectangle {
                    id: topBarDescription
                    y: 21
                    height: 25
                    //color: "#30343f"
                    color: "#25262a"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: leftMenu.width
                    anchors.bottomMargin: 0

                    Label {
                        id: labelTopInfo
                        color: "#6e7e98"
                        text: qsTr('Select sequence and required settings then click the "Convert" button')
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        verticalAlignment: Text.AlignVCenter
                        anchors.rightMargin: 300
                        anchors.leftMargin: 10
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0
                    }

                }

                Rectangle {
                    id: titleBar
                    height: 35
                    color: "#00000000"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 105
                    anchors.leftMargin: 70
                    anchors.topMargin: 0

                    DragHandler {
                        onActiveChanged: if (active && windowMaximizedStatus == false) {
                                             mainWindow.startSystemMove()
                                         }
                    }

                    Label {
                        id: label
                        color: "#96a9ce"
                        text: qsTr("Sequence to Video Converter")
                        //text: output_path
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 10
                        renderType: Text.QtRendering
                        textFormat: Text.AutoText
                        anchors.leftMargin: 10
                    }
                }

                Row {
                    id: rowBtns
                    x: 561
                    width: 70
                    height: 35
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 0
                    anchors.topMargin: 0

                    TopBarButton {
                        id: btnMinimize
                        anchors.right: btnClose.left
                        anchors.rightMargin: 0
                        onClicked: mainWindow.showMinimized()
                    }

                    TopBarButton {
                        id: btnClose
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        btnColorMouseOver: "#ff377a"
                        btnColorClicked: "#ff0051"
                        btnIconSource: "../images/svg_images/close_icon.svg"
                        onClicked: mainWindow.close()
                    }
                }
            }

            Rectangle {
                id: content
                color: "#00000000"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: topBar.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 0

                Rectangle {
                    id: leftMenu
                    width: 70
                    color: "#1c1d20"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    clip: true
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0
                    anchors.leftMargin: 0

                    PropertyAnimation {
                        id: animationMenu
                        target: leftMenu
                        property: "width"
                        to: if (leftMenu.width == 150) return 70; else return 150;
                        duration: 250
                        easing.type: Easing.InOutQuint
                    }


                    Column {
                        id: columnMenus
                        width: 70
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        clip: true
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 90
                        anchors.topMargin: 0

                        LeftMenuBtn {
                            id: btnHome
                            width: leftMenu.width
                            text: qsTr("Home")
                            isActiveMenu: true
                            onClicked: {
                                btnHome.isActiveMenu = true
                                btnOpen.isActiveMenu = false
                                btnSave.isActiveMenu = false
                                btnSettings.isActiveMenu = false
                                loaderHome.visible = true
                                loaderSettings.visible = false
                            }
                        }

                        LeftMenuBtn {
                            id: btnOpen
                            width: leftMenu.width
                            text: qsTr("Open")
                            btnIconSource: "../images/svg_images/open_icon.svg"
                            onClicked: {
                                fileOpen.open()
                            }
                            FileDialog {
                                id: fileOpen
                                title: "Select one of the sequence files."
                                //folder: shortcuts.home
                                folder: {sequence_folder == "" ? shortcuts.home : sequence_folder}
                                selectMultiple: false
                                nameFilters: ["Image files (*.jpg *.png *.tif *.jpeg *.tiff)"]
                                onAccepted: {
                                        console.log(fileOpen.folder)
                                        console.log(fileOpen.fileUrl)
                                        backend.openFile(fileOpen.fileUrl)
                                        backend.printLog()
                                        //backend.openFile(fileOpen.fileURL)
                                    }


                            }
                        }

                        LeftMenuBtn {
                            id: btnSave
                            width: leftMenu.width
                            text: qsTr("Save")
                            btnIconSource: "../images/svg_images/save_icon.svg"
                        }


                    }

                    LeftMenuBtn {
                        id: btnSettings
                        width: leftMenu.width
                        text: qsTr("Settings")
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 25
                        btnIconSource: "../images/svg_images/settings_icon.svg"
                        onClicked: {
                            btnHome.isActiveMenu = false
                            btnOpen.isActiveMenu = false
                            btnSave.isActiveMenu = false
                            btnSettings.isActiveMenu = true
                            //source :Qt.resolvedUrl("pages/settingsPage.qml")
                            loaderHome.visible = false
                            loaderSettings.visible = true

                        }
                    }
                }

                Rectangle {
                    id: contentPages
                    color: "#00000000"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    clip: true
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 25
                    anchors.topMargin: 0

                    Loader {
                        id: loaderHome
                        anchors.fill: parent
                        source : Qt.resolvedUrl("pages/homePage.qml")
                        visible: true

                    }
                    Loader {
                        id: loaderSettings
                        height: 373
                        anchors.fill: parent
                        source : Qt.resolvedUrl("pages/settingsPage.qml")
                        visible: false
                    }

                }

                Rectangle {
                    id: rectangleBottom
                    height: 25
                    color:  "#25262a"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0

                    Label {
                        id: labelBottomInfo
                        color: "#6e7e98"
                        text: mainWindow.bottom_info
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 10
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0
                    }

                    MouseArea {
                        id: mouseArea
                        width: 20
                        height: 20
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 0
                        cursorShape: windowMaximizedStatus ? Qt.ArrowCursor : Qt.SizeFDiagCursor
                        Image {
                            id: resizeImage
                            width: 20
                            height: 20
                            opacity: 0.5
                            source: "../images/svg_images/resize_icon.svg"
                            sourceSize.height: 20
                            sourceSize.width: 20
                            antialiasing: true
                            fillMode: Image.PreserveAspectFit
                        }

                        DragHandler {
                            target: null
                            //onActiveChanged: if (active && windowMaximizedStatus == false) {mainWindow.startSystemResize(Qt.BottomEdge | Qt.RightEdge)}
                            onActiveChanged: if (active && windowMaximizedStatus == false) {mainWindow.startSystemResize(Qt.RightEdge)}
                        }



                    }
                }
            }
        }
    }

    QtObject {
        id: internal

    }

    MouseArea {
        id: resizeRight
        width: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        anchors.leftMargin: 0
        cursorShape: windowMaximizedStatus ? Qt.ArrowCursor : Qt.SizeHorCursor
        DragHandler {
            target: null
            onActiveChanged: if (active && windowMaximizedStatus == false) { mainWindow.startSystemResize(Qt.RightEdge)}
        }
    }

    PropertyAnimation {
        id: animMain
        target: mainWindow
        property: "height"
        to: if (mainWindow.height == 550) return 390; else return 550;
        duration: if (mainWindow.height == 550) return 10; else return 10;
        easing.type: Easing.InOutQuint
    }
//    Button {
//        x: 23
//        y: 339
//        width: 40
//        onClicked:backend.welcomeText(mainWindow.title)

//    }


//Component.onCompleted: backend.configur()
//Component.onCompleted: backend.testing(mainWindow.width)
Component.onCompleted: {backend.defaultVal()
                        backend.printLog()
                        backend.pathsForUI()
                        //labelBottomInfo.text = mainWindow.bottom_info
                        //console.log(labelBottomInfo.text)
                        }
Connections {
    target: backend
        function onSetFps(val)          { fps = val }
        function onSetFormat(val)       { format = val }
        function onSetAlpha(val)        { alpha = val }
        function onSetQuality(val)      { quality = val }
        function onSetBitrate(val)      { bitrate = val }
        function onSetRemove(val)       { remove = val  }
        function onSetChange_output(val){ change_output = val }
        function onSetOutput_path(val)  { output_path = val }

        function onSetPrintLog(val)     { mainWindow.bottom_info = val}

        function onSetSequence_mask(val)      { mainWindow.sequence_mask = val }
        function onSetSequence_folder(val)    { mainWindow.sequence_folder = val }
        function onSetOutput_file_name(val)   { mainWindow.output_file_name = val }

}
}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.6600000262260437}
}
##^##*/
