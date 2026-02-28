#Requires AutoHotkey v2
SetTitleMatchMode 2

; Set your variables
BROWSER := "Brave"
TABS_TO_JOIN := 12
CSV := "C:\subreddits.csv"

; Hotkeys
#f10::Pause ; Pause/resume the script
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
    Sleep 300

    ToolTip "Processing: " subreddit "`n" current " / " total

    ; Focus address bar
    Send "^l"
    Sleep 300

    ; Navigate to subreddit
    Send url
    Send "{Enter}"
    Sleep 2000

    ; Check if already joined and skip
    Send "^a"
    Sleep 300
    Send "^c"
    ClipWait(2)
    Sleep 300

    z := A_Clipboard

    if InStr(z, "Joined")
    {
        continue
    }

    ; Navigate to Join button
    Loop TABS_TO_JOIN
        Send "{Tab}"
    Sleep 300
    Send "{Enter}"

    Sleep 2000
}

; Exit on completion
if (current := total)
{
    ExitApp
}
