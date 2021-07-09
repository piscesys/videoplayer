/*
 * SPDX-FileCopyrightText: 2020 George Florea Bănuș <georgefb899@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import QtQuick 2.12
import QtQuick.Controls 2.12

Menu {
    id: root

    title: i18n("&File")

    MenuItem { action: actions["openAction"] }
    MenuItem { action: actions["openUrlAction"] }

    MenuSeparator {}

    MenuItem { action: actions["quitApplicationAction"] }
}
