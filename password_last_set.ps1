# Ask for username
Write-Host -NoNewline "Username: "
$username = (Read-Host).Trim()

# Ask whether this is a domain account
while ($true) {
    Write-Host -NoNewline "Domain (y/n)? "
    $domainAnswer = (Read-Host).Trim().ToLowerInvariant()

    if ($domainAnswer -in @('y', 'yes')) {
        $useDomain = $true
        break
    }
    elseif ($domainAnswer -in @('n', 'no')) {
        $useDomain = $false
        break
    }
    else {
        Write-Host "Please enter yes, no, y, or n."
    }
}

# Build the net user command arguments
$netArgs = @('user', $username)

if ($useDomain) {
    $netArgs += '/domain'
}

# Run command and extract "Password last set"
Write-Host ""

& net @netArgs | Select-String -Pattern 'Password\sLast\sset\s+(\d{1,2}/){2}\d{4}\s\d{1,2}(:\d{1,2}){2}\s(AM|PM)'

Write-Host ""
Write-Host ('_' * 49)
Write-Host ""
