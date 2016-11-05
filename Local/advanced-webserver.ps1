$httpListener = New-Object Net.HttpListener
$httpListener.Prefixes.Add("http://+:10000/")

function Processes([String]$processName="") {
    if ($processName -eq "") {
        return Get-Process
    } else {
        return Get-Process -Name $processName
    }
}

$httpListener.Start()

While ($httpListener.IsListening) {
    $context = $httpListener.GetContext()
    $request = $context.Request
    $response = $context.Response
    $response.Headers.Add("Content-Type", "text/html")

    # This will terminate the script.
    if ($request.Url -match '/end$') { break }

    if($Context.Request.Url.LocalPath -eq "/processes")
    {
        $output = Processes($Context.Request.QueryString["ProcessName"]) | select name,cpu,virtualmemorysize | ConvertTo-Html | Out-String
    } else {
        $output = [Text.Encoding]::UTF8.GetBytes("Hello, Memphis Tech Talks")
    }

    $response.ContentLength64 = $output.Length
    $response.OutputStream.Write($output, 0, $output.Length)
    $response.Close()
}

$httpListener.Stop()