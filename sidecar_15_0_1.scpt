on showHelp()
    set helpMessage to "用法：\n" & ¬
        "osascript script.scpt <iPadName>\n" & ¬
        "参数：\n" & ¬
        "  -h  显示帮助信息\n" & ¬
        "  <iPadName>  要连接的 iPad 的名称"
    log(helpMessage)
    return 
end showHelp

on init()
    tell application "System Events"
        set the visible of every process to false
    end tell
end init

on openSystemSettings()
    tell application "System Settings"
        activate
    end tell
    delay 0.1
end openSystemSettings

on configSideCar(ipadName)
    tell application "System Events"
        tell process "System Settings"
            -- 打开显示器设置
            click menu item "显示器" of menu "显示" of menu bar item "显示" of menu bar 1 
            -- 模拟点击“添加显示器”按钮，稍作延时
            click pop up button 1 of group 1 of group 2 of splitter group 1 of group 1 of window 1
            -- 模拟点击你的 iPad 名称
            delay 0.5
            click menu item ipadName of menu "添加" of pop up button "添加" of group 1 of group 2 of splitter group 1 of group 1 of window 1
        end tell
    end tell
    return 
end configSideCar

on run argv
    if (count of argv) = 0 then
        log("请传入要连接的 iPad 名称。使用 -h 查看帮助。")
        return 
    end if

    set ipadName to item 1 of argv

    if ipadName is "-h" then
        showHelp()
        return 
    end if

    init()
    openSystemSettings() 
    configSideCar(ipadName) 
end run


