$OUTPUTFILE="Result.txt"
Remove-Item $OUTPUTFILE -Force

foreach($line in Get-Content .\HostNames.txt) {
    echo $line
    $result = $(curl https://www.nigsun.net/lg/whois.php?domain=$line)
    $result.Content.Split("`n") | ForEach-Object {
        if($_ -match "Record created" -or $_ -match "Creation Date" -or $_ -match "No Found" -or $_ -match "No match" ) {
            echo "$line $_" >> $OUTPUTFILE;             
        };
    }
}