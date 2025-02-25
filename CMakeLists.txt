cmake_minimum_required(VERSION 3.14)

project(pisces-videoplayer LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

find_package(Qt5 COMPONENTS Core Quick DBus Widgets LinguistTools REQUIRED)
find_package(Libmpv)

qt5_add_dbus_interface(screensaver_inhibit_SRCS ./org.freedesktop.ScreenSaver.xml screensaverdbusinterface)

set(PROJECT_SOURCES
    src/main.cpp
    src/application.cpp
    src/playlistmodel.cpp
    src/playlistitem.cpp
    src/track.cpp
    src/tracksmodel.cpp
    src/mpvobject.cpp
    src/qthelper.h
    src/lockmanager.cpp
    src/mpris2/mediaplayer2.cpp
    src/mpris2/mediaplayer2player.cpp
    qml.qrc
    ${screensaver_inhibit_SRCS}
)

add_executable(pisces-videoplayer
    ${PROJECT_SOURCES}
)

target_link_libraries(pisces-videoplayer
  PRIVATE
  Qt5::Core
  Qt5::Quick
  Qt5::DBus
  Qt5::Widgets
  Libmpv::Libmpv
)

install(TARGETS pisces-videoplayer DESTINATION ${CMAKE_INSTALL_BINDIR})

install(FILES
    pisces-videoplayer.desktop
    DESTINATION /usr/share/applications/
    COMPONENT Runtime
)

file(GLOB TS_FILES translations/*.ts)
qt5_create_translation(QM_FILES ${TS_FILES})
add_custom_target(translations DEPENDS ${QM_FILES} SOURCES ${TS_FILES})
add_dependencies(pisces-videoplayer translations)

install(FILES ${QM_FILES} DESTINATION /usr/share/pisces-videoplayer/translations)
