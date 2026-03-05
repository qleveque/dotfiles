DetectHiddenWindows, On

ToggleDeepL() {
    if WinExist("DeepL") {
        if WinActive("DeepL") {
            WinMinimize, DeepL
            WinHide, DeepL
        } else {
            WinRestore, DeepL
            WinActivate, DeepL
            WinSet, AlwaysOnTop, On, DeepL
        }
    }
}
