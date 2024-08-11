on error resume next
Err.clear
Set service = CreateObject("Schedule.Service")
service.Connect
dim Installed
Installed = 0
Set rootFolder = service.GetFolder("\HardDiskSentinel")
if Err.Number<>0 then
	Wscript.Echo "NOT installed"
	Wscript.Quit
	end if
Set colTasks = rootFolder.GetTasks(0)
For Each task In colTasks
	if (task.Name="Hard Disk Sentinel_USER") then
	Installed = 1
	Exit For
	end if
Next
if (installed=1) then
	Wscript.Echo "Already installed"
else
	Wscript.Echo "NOT installed"
end if
