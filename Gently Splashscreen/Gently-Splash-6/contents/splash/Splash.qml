/*
 *   Copyright 2014 Marco Martin <mart@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.5

Image {
    id: root
    source: "images/Krunica.png"
    fillMode: Image.PreserveAspectCrop

    property int stage

    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true
        }
    }
    TextMetrics {
        id: units
        text: "M"
        property int gridUnit: boundingRect.height 
    }

    Rectangle {
        id: topRect
        width: parent.width
        height: units.gridUnit * 12
        anchors.centerIn: parent
        color: "#4C000000"
        Column {
            id: content
            y: units.gridUnit
            x: parent.width
            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                source: ""
                sourceSize.height: units.gridUnit * 10
                sourceSize.width: sourceSize.height
            }
            Item {
                width: 1
                height: Math.round(units.gridUnit * 3 - progressBar.height/2)
            }
            Rectangle {
                id: progressBar
                radius: height
                color: "#d8d8d8"
                height: Math.round(units.gridUnit/4)
                width: height*60
                Rectangle {
                    radius: 3
                    anchors {
                        left: parent.left
                        top: parent.top
                        bottom: parent.bottom
                    }
                    width: (parent.width /5) * (stage - 1)
                    color: "#c83771"
                    Behavior on width {
                        PropertyAnimation {
                            duration: 450
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
            }
        }
        Rectangle {
            id: separator
            height: 1
            color: "#c83771"
            width: parent.width
            opacity: 0.4
            y: parent.height - units.gridUnit * 3
        }
    }

    XAnimator {
        id: introAnimation
        running: false
        target: content
        from: root.width
        to: root.width / 2 - content.width/2
        duration: 1000
        easing.type: Easing.InOutQuad
    }
}
