#Requires AutoHotkey v2
SetTitleMatchMode 2

; Set your variables
BROWSER := "Brave"
TABS_TO_JOIN := 11
CSV := "C:\subreddits.csv"
SHORT_SLEEP := 500 ; Short sleep length
LONG_SLEEP := 4000 ; Long sleep length

; Hotkeys
#f10::Pause ; Pause the script, use system tray icon to resume
#f12::ExitApp ; Exit the script

; Count total subreddits
total := 0
Loop Read CSV
{
    if (Trim(A_LoopReadLine) != "")
        total++
}

current := 0

Loop Read CSV
{
    subreddit := Trim(A_LoopReadLine)

    if (subreddit = "")
        continue
    
    current++

    url := "https://www.reddit.com/r/" subreddit

    ; Activate browser window
    if !WinExist(BROWSER)
    {
        MsgBox "Please open " . BROWSER . " and log into Reddit first."
        ExitApp
    }

    WinActivate BROWSER
    Sleep SHORT_SLEEP

    ToolTip "Processing: " subreddit "`n" current " / " total

    ; Focus address bar
    Send "^l"
    Sleep SHORT_SLEEP

    ; Navigate to subreddit
    Send url
    Send "{Enter}"
    Sleep LONG_SLEEP

    ; Check if already joined and skip
    Send "^a"
    Sleep SHORT_SLEEP
    Send "^c"
    ClipWait(2)
    Sleep SHORT_SLEEP

    z := A_Clipboard

    if InStr(z, "Joined")
    {
        continue
    }

    ; Navigate to Join button
    Loop TABS_TO_JOIN
        Send "{Tab}"
    Sleep SHORT_SLEEP
    Send "{Enter}"

    Sleep LONG_SLEEP
}

; Exit on completion
if (current := total)
{
    ExitApp
}
