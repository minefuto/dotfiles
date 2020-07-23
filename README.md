# dotfiles

macOS
```
export PATH=$HOME/.nimble/bin:$PATH
curl -L https://github.com/minefuto/dotprov/releases/download/v0.2.0/dotprov_macOS_amd64.tar.gz | tar zx
./dotprov_macOS_amd64/dotprov setup minefuto/dotfiles
```

windows
```
curl -OL https://github.com/minefuto/dotprov/releases/download/v0.2.0/dotprov_windows_amd64.zip
Expand-Archive -Path .\dotprov_windows_amd64.zip -DestinationPath .
.\dotprov_windows_amd64\dotprov setup minefuto/dotfiles
```

linux
```
export PATH=$HOME/.nimble/bin:$PATH
curl -L https://github.com/minefuto/dotprov/releases/download/v0.2.0/dotprov_linux_amd64.tar.gz | tar zx
./dotprov_linux_amd64/dotprov setup minefuto/dotfiles
```
