$httpListener = New-Object Net.HttpListener
$httpListener.Prefixes.Add("http://+:10001/")
$httpListener.Start()

While ($httpListener.IsListening) {
    $context = $httpListener.GetContext()
    $request = $context.Request
    $response = $context.Response
    $response.Headers.Add("Content-Type", "text/html")

    # This will terminate the script.
    if ($request.Url -match '/end$') { break }

    $output = [Text.Encoding]::UTF8.GetBytes("Hello, TechCamp")

    $response.ContentLength64 = $output.Length
    $response.OutputStream.Write($output, 0, $output.Length)
    $response.Close()
}

$httpListener.Stop()