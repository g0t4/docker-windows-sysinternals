FROM microsoft/nanoserver
MAINTAINER Wes Higbee <wes.mcclure@gmail.com>

ENV SYSINTERNALS_DOWNLOAD_URL "https://download.sysinternals.com/files/SysinternalsSuite-Nano.zip"

# PowerShell Core doesn't contain Invoke-WebRequest, using .NET Core's HttpClient instead
# then using .NET Core's ZipFile.ExtractToDirectory to extract the downloaded zip file
# then removing the zip file to reduce image layer size
RUN powershell.exe -Command ; \
    $client = New-Object System.Net.Http.HttpClient ; \
    $responseMsg = $client.GetAsync([System.Uri]::new('%SYSINTERNALS_DOWNLOAD_URL%')) ; \
    $responseMsg.Wait() ; \
    $downloadedFileStream = [System.IO.FileStream]::new('c:\sysinternals.zip', [System.IO.FileMode]::Create, [System.IO.FileAccess]::Write) ; \
    $response = $responseMsg.Result ; \
    $copyStreamOp = $response.Content.CopyToAsync($downloadedFileStream) ; \
    $copyStreamOp.Wait() ; \
    $downloadedFileStream.Close() ; \
    [System.IO.Compression.ZipFile]::ExtractToDirectory('c:\sysinternals.zip','c:\sysinternals-nano') ; \
    Remove-Item c:\sysinternals.zip -Force

WORKDIR C:\\sysinternals-nano
