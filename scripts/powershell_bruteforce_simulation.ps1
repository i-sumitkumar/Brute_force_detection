$user = "testuser"
$wrongpass = "WrongPassword123"

for ($i = 1; $i -le 15; $i++) {
    cmd /c "net use \\127.0.0.1\IPC$ /user:$user $wrongpass"
    Start-Sleep -Milliseconds 500
}
