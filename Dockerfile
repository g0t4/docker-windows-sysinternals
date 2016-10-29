FROM microsoft/nanoserver
MAINTAINER Wes Higbee <wes.mcclure@gmail.com>

ENV SYSINTERNALS_DOWNLOAD_URL "https://download.sysinternals.com/files/SysinternalsSuite-Nano.zip"

# PowerShell Core doesn't contain Invoke-WebRequest, using .NET Core's HttpClient instead
# then using .NET Core's ZipFile.ExtractToDirectory to extract the downloaded zip file
# then removing the zip file to reduce image layer size
RUN powershell.exe -Command ; \
    $responseMsg = (New-Object System.Net.Http.HttpClient).GetAsync('%SYSINTERNALS_DOWNLOAD_URL%'); \
    $stream = $responseMsg.Result.Content.ReadAsStreamAsync().Result; \
    $archive = New-Object System.IO.Compression.ZipArchive($stream); \
    [System.IO.Compression.ZipFileExtensions]::ExtractToDirectory($archive, 'c:\sysinternals-nano');

WORKDIR C:\\sysinternals-nano
