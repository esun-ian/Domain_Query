$OUTPUTFILE="Result.txt"
Remove-Item $OUTPUTFILE -Force

foreach($line in Get-Content .\HostNames.txt) {
    echo $line
    start powershell -argument ".\query.ps1 $line" -wait -NoNewWindow
}