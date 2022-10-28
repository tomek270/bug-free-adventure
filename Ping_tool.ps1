##Tool for monitoring ping connection between hosts. 
Write-Host "Tool for monitoring ping connection between hosts."
Write-Host "To end use Ctrl+C"
$address = read-host "Type address which you want to ping:"
$log_path = "C:\scripts\ping_logs\ping_log_$address.txt"
$dir_path = "C:\scripts\ping_logs"
Write-Host = "Log file path is $log_path"
$test_dir_path = Test-Path $dir_path
if ($test_dir_path){
    Write-Host "Path $dir_path exists."
}
else {
    Write-Host "Path $dir_path not exists. Will be created."
    New-Item -Path $dir_path -ItemType Directory
}
$test_log_path = Test-Path $log_path
if ($test_log_path){
    $clean_log = read-host "Log file exists. If you want to clear it type 1"
    if ($clean_log -eq 1){
        Remove-Item $log_path
        Write-Host " $log_path cleared."
    }
}
ping $address -t | ForEach-Object {
    if ($_ -like "*Pinging $address*") {
        Write-Host "Start pinging # $_"}
    elseif ($_ -like "*bytes*time*TTL*"){
        Write-Host "Ping OK # $_"}
    else {
        Write-Host "$address is not pinging # $_"
        $data=Get-Date
        "$data $_" | Add-Content $log_path}
    }


    Write-Host "Koniec skryptu"
