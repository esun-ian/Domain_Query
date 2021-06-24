$OUTPUTFILE="Result.txt"
Remove-Item $OUTPUTFILE -Force

#$user = $(whoami).Split('\')[1]
$user = $(whoami)
echo "使用登入開機帳號驗證 Proxy: $user"

$passwd = Read-Host "請輸入登入開機密碼: " -AsSecureString
$myCreds=New-Object System.Management.Automation.PSCredential -ArgumentList "$user",$passwd

Set-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" ProxyEnable -value 1


foreach($line in Get-Content .\HostNames.txt) {
    echo $line
    $result = $(curl https://www.nigsun.net/lg/whois.php?domain=$line -Proxy 'http://172.17.12.36:8080'  -ProxyCredential $myCreds)
    $result.Content.Split("`n") | ForEach-Object {
        if($_ -match "Record created" -or $_ -match "Creation Date" -or $_ -match "No Found" -or $_ -match "No match" ) {
            echo "$line $_" >> $OUTPUTFILE;             
        };
    }
    echo "等待2秒..."
    start-sleep -s 2
}