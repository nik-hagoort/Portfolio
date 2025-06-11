param($Request, $TriggerMetadata)

$apiKey     = $env:AZURE_OPENAI_KEY
$endpoint   = $env:AZURE_OPENAI_ENDPOINT
$deployment = $env:AZURE_OPENAI_DEPLOYMENT
$question   = $Request.Body.question

# Ensure endpoint URL is properly formatted (remove trailing slash if present)
$endpoint = $endpoint.TrimEnd('/')

# Use the correct Azure OpenAI API endpoint format
$uri = "$endpoint/openai/deployments/$deployment/chat/completions?api-version=2024-02-15-preview"

$body = @{
    messages = @(
        @{ role = "system"; content = "You are an IT helpdesk assistant. Answer concisely and helpfully." }
        @{ role = "user"; content = $question }
    )
    max_tokens = 500
    temperature = 0.7
} | ConvertTo-Json -Depth 3

# Add detailed logging for debugging
Write-Host "Making request to: $uri"
Write-Host "Using deployment: $deployment"

try {
    # Validate required environment variables
    if (-not $apiKey) {
        throw "AZURE_OPENAI_KEY environment variable is not set"
    }
    if (-not $endpoint) {
        throw "AZURE_OPENAI_ENDPOINT environment variable is not set"
    }
    if (-not $deployment) {
        throw "AZURE_OPENAI_DEPLOYMENT environment variable is not set"
    }
    if (-not $question) {
        throw "No question provided in request body"
    }

    $response = Invoke-RestMethod -Uri $uri -Method POST -Headers @{
        "api-key" = $apiKey
        "Content-Type" = "application/json"
    } -Body $body

    $answer = $response.choices[0].message.content
}
catch {
    # Enhanced error handling with more details
    $errorMessage = $_.Exception.Message
    
    # Check for specific HTTP status codes
    if ($_.Exception -is [System.Net.WebException]) {
        $httpResponse = $_.Exception.Response
        if ($httpResponse) {
            $statusCode = [int]$httpResponse.StatusCode
            $statusDescription = $httpResponse.StatusDescription
            $errorMessage = "HTTP $statusCode - $statusDescription"
            
            # Add specific guidance for common errors
            switch ($statusCode) {
                404 { $errorMessage += ". Check your endpoint URL and deployment name." }
                401 { $errorMessage += ". Check your API key." }
                429 { $errorMessage += ". Rate limit exceeded. Try again later." }
                500 { $errorMessage += ". Azure OpenAI service error. Try again later." }
            }
        }
    }
    
    Write-Host "Error occurred: $errorMessage"
    Write-Host "Endpoint: $endpoint"
    Write-Host "Deployment: $deployment"
    Write-Host "Full URI: $uri"
    
    $answer = "Error: $errorMessage"
}

Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = 200
    Body = @{
        question = $question
        answer   = $answer
    }
})
