FROM microsoft/nanoserver
MAINTAINER Wes Higbee <wes.mcclure@gmail.com>

RUN powershell.exe -Command \
    $ErrorActionPreference = 'Stop'; \
    # Right now using same install as for NanoServer
    $url = 'https://download.sysinternals.com/files/SysinternalsSuite-Nano.zip'; \
    Invoke-WebRequest $url -OutFile suite.zip; \
    Expand-Archive suite.zip 'c:\sysinternals-nano'; \
    rm suite.zip

WORKDIR C:\\sysinternals-nano

