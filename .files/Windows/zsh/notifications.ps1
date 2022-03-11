$applicationName = $args[0]
$title = $args[1]
$body = $args[2]

# show notification for 10 seconds
#$timeout = 10
#
#[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-null
#[reflection.assembly]::loadwithpartialname("System.Drawing")       | Out-null
#
#$notify = new-object system.windows.forms.notifyicon
#$notify.icon = [System.Drawing.SystemIcons]::Information
#$notify.visible = $true
#
## show tip for 10 seconds
#$notify.showballongtip($timeout, "$title", "$body", [system.windows.forms.tooltipicon]::None)


[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
[Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null

$template = @"
<toast>
	<visual>
		<binding template="ToastText02">
			<text id="1">$($title)</text>
			<text id="2">#($body)</text>
		</binding>
	</visual>
</toast>
"@

$xml = New-Object Windows.Data.Xml.Dom.XmlDocument
$xml.LoadXml($template)
$toast = New-Object Windows.UI.Notifications.ToastNotification $xml
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($applicationName).Show($toast)
