$SUBJECT=$args[0]
$DETAILS=$args[1]

[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-null
[reflection.assembly]::loadwithpartialname("System.Drawing")       | Out-null

$notify = new-object system.windows.forms.notifyicon
$notify.icon = [System.Drawing.SystemIcons]::Information
$notify.visible = $true

# show tip for 10 seconds
$notify.showballongtip(10, "$SUBJECT", "$DETAILS", [system.windows.forms.tooltipicon]::None)
