# docker-windows-sysinternals

Docker images with sysinternals baked in for spelunking what's going on inside windows containers.

# Exercises

```powershell

# Run a vanilla Command Prompt in a nanoserver container:
docker run --rm -it weshigbee/sysinternals 

# Then inside the container:
# This will list handles used by the Command Prompt running in the container. 
handle64.exe -accepteula -p cmd  -a

# Then, run handle64.exe on the host targeting the PID returned from the container call to handle64 above, you'll notice differences that highlight the isolation of the container. Note: this is most interesting on a Windows Server machine because you can use a Windows Server container instead of a Hyper-V container, though a good exercise would be to vary the isolation type and try out both Windows container types.
docker run --rm --isolation=hyperv -it weshigbee/sysinternals

```
