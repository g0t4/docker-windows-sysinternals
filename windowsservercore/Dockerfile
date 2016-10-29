FROM microsoft/windowsservercore
MAINTAINER Wes Higbee <wes.mcclure@gmail.com>

# Right now using same install as for NanoServer
ENV SYSINTERNALS_DOWNLOAD_URL "https://download.sysinternals.com/files/SysinternalsSuite-Nano.zip"

RUN powershell.exe -Command ; \
    # PowerShell Core doesn't contain Invoke-WebRequest, using .NET Core's HttpClient instead 
    $response = (New-Object System.Net.Http.HttpClient).GetAsync('%SYSINTERNALS_DOWNLOAD_URL%').Result; \
    $responseStream = $response.Content.ReadAsStreamAsync().Result; \
    # use ZipArchive to extract the response stream (a zip file) to disk
    $archive = New-Object System.IO.Compression.ZipArchive($responseStream); \
    [System.IO.Compression.ZipFileExtensions]::ExtractToDirectory($archive, 'c:\sysinternals-nano');

WORKDIR C:\\sysinternals-nano

