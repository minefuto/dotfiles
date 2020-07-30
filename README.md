# dotfiles

macOS
```
export PATH=$HOME/.nimble/bin:$PATH
curl -L https://github.com/minefuto/dotprov/releases/download/v0.2.2/dotprov_macos_amd64.tar.gz | tar zx
./dotprov setup minefuto/dotfiles
```

windows(Need to install `git` command)
```
set PATH=%PATH%;C:\ProgramData\chocolatey\bin
curl -OL https://github.com/minefuto/dotprov/releases/download/v0.2.0/dotprov_windows_amd64.zip
powershell Expand-Archive -Path .\dotprov_windows_amd64.zip -DestinationPath .
.\dotprov setup minefuto/dotfiles
```

linux
```
export PATH=$HOME/.nimble/bin:$PATH
curl -L https://github.com/minefuto/dotprov/releases/download/v0.2.0/dotprov_linux_amd64.tar.gz | tar zx
./dotprov_linux_amd64/dotprov setup minefuto/dotfiles
```
