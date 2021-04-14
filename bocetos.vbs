set WshShell = CreateObject("WScript.Shell")
 WScript.Sleep 1000
 WshShell.SendKeys "bocetos" 'in quotes
 WScript.Sleep 500
 WshShell.Sendkeys "{ENTER}"
 set WshShell = nothing