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
        return
    } else {
	Run, %A_AppData%\Roaming\Programs\ZeroInstall\0install-win.exe run https://appdownload.deepl.com/windows/0install/deepl.xml
    }
}
