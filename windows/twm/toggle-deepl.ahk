DetectHiddenWindows, On

DeepLOpen := false

ToggleDeepL() {
    global DeepLOpen
    if WinExist("DeepL") && DeeplOpen {
        if WinActive("DeepL") {
            WinMinimize, DeepL
            WinHide, DeepL
        } else {
            WinRestore, DeepL
            WinActivate, DeepL
            WinSet, AlwaysOnTop, On, DeepL
        }
        return
    } else {
        Run, "%A_AppData%\Programs\Zero Install\0install-win.exe" run https://appdownload.deepl.com/windows/0install/deepl.xml
        DeepLOpen := true
    }
}
