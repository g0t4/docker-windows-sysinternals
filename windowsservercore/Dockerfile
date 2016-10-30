FROM microsoft/windowsservercore
MAINTAINER Wes Higbee <wes.mcclure@gmail.com>

# Right now using same install as for NanoServer
ENV SYSINTERNALS_DOWNLOAD_URL "https://download.sysinternals.com/files/SysinternalsSuite-Nano.zip"

RUN powershell.exe -Command ; \
    $ErrorActionPreference = 'Stop'; \
    Add-Type -AssemblyName System.Net.Http; \
    Add-Type -AssemblyName System.IO.Compression; \
    Add-Type -AssemblyName System.IO.Compression.FileSystem; \
    # PowerShell Core doesn't contain Invoke-WebRequest, using .NET Core's HttpClient instead 
    # use get_Result() to ensure task exceptions are rethrown
    $responseStream = (New-Object System.Net.Http.HttpClient).GetStreamAsync('%SYSINTERNALS_DOWNLOAD_URL%').get_Result(); \
    # use ZipArchive to extract the response stream (a zip file) to disk
    $archive = New-Object System.IO.Compression.ZipArchive($responseStream); \
    [System.IO.Compression.ZipFileExtensions]::ExtractToDirectory($archive, 'c:\sysinternals-nano');

WORKDIR C:\\sysinternals-nano

