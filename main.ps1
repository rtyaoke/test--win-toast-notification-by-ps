# Ref)
# https://qiita.com/relu/items/b7121487a1d5756dfcf9#powershell-71-%E4%BB%A5%E9%99%8D%E3%82%92%E4%BD%BF%E3%81%86%E5%A0%B4%E5%90%88
#
# need Powershell 7.1 after


if (!(Test-Path WinRT.Runtime.dll)){
    Invoke-WebRequest https://github.com/Windos/BurntToast/raw/main/BurntToast/lib/Microsoft.Windows.SDK.NET/WinRT.Runtime.dll -OutFile WinRT.Runtime.dll
}
Add-Type -Path WinRT.Runtime.dll

if (!(Test-Path Microsoft.Windows.SDK.NET.dll)){
    Invoke-WebRequest https://github.com/Windos/BurntToast/raw/main/BurntToast/lib/Microsoft.Windows.SDK.NET/Microsoft.Windows.SDK.NET.dll -OutFile Microsoft.Windows.SDK.NET.dll
}
Add-Type -Path Microsoft.Windows.SDK.NET.dll

$xml = @"
<toast>
  <visual>
    <binding template="ToastGeneric">
      <text>Hello World</text>
      <text>This is a simple toast message</text>
    </binding>
  </visual>
</toast>
"@
$XmlDocument = [Windows.Data.Xml.Dom.XmlDocument]::New()
$XmlDocument.loadXml($xml)
$AppId = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppId).Show($XmlDocument)
