on error resume next
Err.clear
const TriggerTypeLogon = 9
const ActionTypeExecutable = 0
const TASK_INSTANCES_IGNORE_NEW = 2
const createOrUpdateTask = 6
const TASK_LOGON_INTERACTIVE_TOKEN = 3
const TASK_RUNLEVEL_HIGHEST = 1
Set service = CreateObject("Schedule.Service")
call service.Connect()
Dim rootFolder
Set rootFolder = service.GetFolder("\")
rootFolder.CreateFolder("\HardDiskSentinel")
Set rootFolder = service.GetFolder("\HardDiskSentinel")
Dim taskDefinition
Set taskDefinition = service.NewTask(0)
Dim regInfo
Set regInfo = taskDefinition.RegistrationInfo
regInfo.Description = "Automatically start Hard Disk Sentinel when the user logs on."
regInfo.Author = "H.D.S. (c) 2010."
Dim settings
Set settings = taskDefinition.Settings
settings.StartWhenAvailable = True
settings.ExecutionTimeLimit = "P9999D"
settings.DisallowStartIfOnBatteries = False
settings.StopIfGoingOnBatteries = False
settings.IdleSettings.StopOnIdleEnd = False
settings.MultipleInstances = TASK_INSTANCES_IGNORE_NEW
Dim triggers
Set triggers = taskDefinition.Triggers
Dim trigger
Set trigger = triggers.Create(TriggerTypeLogon)
Dim startTime, endTime
startTime = "2007-01-01T00:00:00"
endTime = "2059-12-31T23:59:59"
trigger.StartBoundary = startTime
trigger.Id = "HardDiskSentinelAutoStart"
trigger.UserId = "USER"
trigger.ExecutionTimeLimit = ""
Dim Action
Set Action = taskDefinition.Actions.Create( ActionTypeExecutable )
Action.Path = "C:\#mirza\APPPortable\hdsentinel\App\Hard Disk Sentinel\HDSentinel.exe"
Action.Arguments = "/AUTORUN"
Dim princ
Set princ = taskDefinition.Principal
princ.UserId = trigger.UserId
princ.LogonType = TASK_LOGON_INTERACTIVE_TOKEN
princ.RunLevel = TASK_RUNLEVEL_HIGHEST
call rootFolder.RegisterTaskDefinition( _
    "Hard Disk Sentinel_USER", taskDefinition, createOrUpdateTask, _
    trigger.UserId, , 3)
WScript.Echo "INSTALLED"
