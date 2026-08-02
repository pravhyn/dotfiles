oh-my-posh init pwsh --config "C:\Users\prave\AppData\Local\Programs\oh-my-posh\themes\catppuccin_mocha.omp.json" | Invoke-Expression


function v {
    while ($true) {
        nvim
    }
}


Set-Alias ls eza



$PSStyle.FileInfo.Directory = "`e[38;2;150;180;210m"

Invoke-Expression (& { (zoxide init powershell | Out-String) })
function zf {
    zoxide query -i | fzf | ForEach-Object { zoxide jump $_ }
}



Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadLineKeyHandler -Chord "Shift+Tab" -Function TabCompleteNext


function cdf {
    $file = Get-ChildItem -Recurse -File | fzf --ansi --tac | ForEach-Object { $_.FullName }
    if ($file) {
        Set-Location (Split-Path $file -Parent)
    }
}


# function ffw {
#     $result = fd --type file --follow --hidden --exclude .git |
#         fzf --prompt 'Files> ' `
#             --header-first `
#             --header 'CTRL-S: Switch between Files/Directories' `
#             --bind 'ctrl-s:transform:if not "%FZF_PROMPT%"=="Files> " (echo ^change-prompt^(Files^> ^)^+^reload^(fd --type file^)) else (echo ^change-prompt^(Directory^> ^)^+^reload^(fd --type directory^))' `
#             --preview 'if "%FZF_PROMPT%"=="Files> " (bat --color=always {} --style=plain) else (eza -T --colour=always --icons=always {})'

#     if (-not $result) { return }

#     # If it's a file → cd to its parent directory
#     if (Test-Path $result -PathType Leaf) {
#         $dir = Split-Path $result -Parent
#         Set-Location $dir
#         return
#     }

#     # If it's already a directory → cd directly
#     if (Test-Path $result -PathType Container) {
#         Set-Location $result
#     }
# }

function cfp {
    Get-ChildItem -File -Recurse |
        Select-Object -ExpandProperty FullName |
        fzf |
        Set-Clipboard
}
function ffw {
    $result = fd --type file --follow --hidden --exclude .git |
        fzf --prompt 'Files> ' `
            --header-first `
            --header 'ENTER: cd  |  CTRL-O: nvim  |  CTRL-I: code  |  CTRL-S: toggle files/dirs' `
            --style minimal `
            --border `
            --preview-window right:60%:wrap `
            --bind 'ctrl-s:transform:if not "%FZF_PROMPT%"=="Files> " (echo ^change-prompt^(Files^> ^)^+^reload^(fd --type file^)) else (echo ^change-prompt^(Directory^> ^)^+^reload^(fd --type directory^))' `
            --bind 'ctrl-o:execute-silent(cmd /c start nvim {})+abort' `
            --bind 'ctrl-i:execute(code {})+abort' `
            --preview 'if "%FZF_PROMPT%"=="Files> " (bat --color=always {} --style=plain) else (eza -T --colour=always --icons=always {})'

    if (-not $result) { return }

    # If file → cd to parent
    if (Test-Path $result -PathType Leaf) {
        Set-Location (Split-Path $result -Parent)
        return
    }

    # If directory → cd directly
    if (Test-Path $result -PathType Container) {
        Set-Location $result
    }
}


function lg {
    $command = 'rg --column --line-number --no-heading --color=always --smart-case {q}'

    fzf --ansi `
        --disabled `
        --prompt 'RG> ' `
        --header 'Type to search | ENTER: nvim | CTRL-V: code' `
        --style minimal `
        --border `
        --bind "change:reload:$command" `
        --bind 'enter:execute-silent(cmd /c start nvim {1} +{2})+abort' `
        --bind 'ctrl-i:execute-silent(cmd /c start code -g {1}:{2})+abort' `
        --delimiter ':' `
        --preview 'bat --color=always {1} --highlight-line {2}' `
        --preview-window 'right:60%:wrap'
}


# function rgf {

#     $RG_PREFIX = "rg --column --line-number --no-heading --color=always --smart-case --glob '!node_modules/*' --glob '!.git/*' --glob '!dist/*' --glob '!target/*'"

#     $TMP_R = "$env:TEMP\rgf-r.txt"
#     $TMP_F = "$env:TEMP\rgf-f.txt"

#     "" |
#     fzf --ansi --disabled `
#         --query "" `
#         --prompt '1. ripgrep> ' `
#         --header 'CTRL-S: rg ↔ fzf | ENTER: nvim | CTRL-V: code' `
#         --header-first `
#         --delimiter ':' `
#         --style minimal `
#         --border `
#         --bind "start:reload:$RG_PREFIX {q}" `
#         --bind "change:reload:sleep 0.1 & $RG_PREFIX {q}" `
#         --bind "ctrl-s:transform:if not '%FZF_PROMPT%'=='1. ripgrep> ' (echo ^rebind^(change^)^+^change-prompt^(1. ripgrep^> ^)^+^disable-search^+^transform-query:echo ^{q^} ^> '$TMP_R' ^& type '$TMP_F') else (echo ^unbind^(change^)^+^change-prompt^(2. fzf^> ^)^+^enable-search^+^transform-query:echo ^{q^} ^> '$TMP_F' ^& type '$TMP_R')" `
#         --bind 'enter:execute-silent(cmd /c start nvim {1} +{2})+abort' `
#         --bind 'ctrl-v:execute-silent(cmd /c start code -g {1}:{2})+abort' `
#         --preview 'bat --color=always {1} --highlight-line {2} --style=plain' `
#         --preview-window 'right,60%,border-left,+{2}+3/3'
# }



function rgf {

    $RG_PREFIX = 'rg --column --line-number --no-heading --color=always --smart-case --glob "!node_modules/*" --glob "!.git/*" --glob "!dist/*" --glob "!target/*"'

    $TMP_R = "$env:TEMP\rgf-r.txt"
    $TMP_F = "$env:TEMP\rgf-f.txt"

    "" |
    fzf --ansi --disabled `
        --query "" `
        --prompt '1. ripgrep> ' `
        --header 'CTRL-S: rg ↔ fzf | ENTER: nvim | CTRL-V: code' `
        --header-first `
        --delimiter ':' `
        --style minimal `
        --border `
        --bind "start:reload:$RG_PREFIX {q}" `
        --bind "change:reload:sleep 0.1 & $RG_PREFIX {q}" `
        --bind "ctrl-s:transform:if not '%FZF_PROMPT%'=='1. ripgrep> ' (echo ^rebind^(change^)^+^change-prompt^(1. ripgrep^> ^)^+^disable-search^+^transform-query:echo ^{q^} ^> '$TMP_R' ^& type '$TMP_F') else (echo ^unbind^(change^)^+^change-prompt^(2. fzf^> ^)^+^enable-search^+^transform-query:echo ^{q^} ^> '$TMP_F' ^& type '$TMP_R')" `
        --bind 'enter:execute-silent(cmd /c start nvim {1} +{2})+abort' `
        --bind 'ctrl-v:execute-silent(cmd /c start code -g {1}:{2})+abort' `
        --preview 'bat --color=always {1} --highlight-line {2} --style=plain' `
        --preview-window 'right,60%,border-left,+{2}+3/3'
}


function fh {
    $histFile = (Get-PSReadLineOption).HistorySavePath

    if (!(Test-Path $histFile)) {
        Write-Error "PSReadLine history file not found"
        return
    }

    $cmd = Get-Content $histFile |
        Where-Object { $_.Trim() -ne "" } |
        Sort-Object -Descending |
        Get-Unique |
        fzf --prompt 'History> ' `
            --style minimal `
            --border `
            --height 60% `
            --header 'ENTER: run | CTRL-E: edit | ESC: cancel' `
            --preview 'echo {}' `
            --preview-window down:3:wrap `
            --bind 'ctrl-e:abort'

    if (-not $cmd) { return }

    # Ctrl-E → put into prompt for editing
    if ($LASTEXITCODE -ne 0) {
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert($cmd)
        return
    }

    # ENTER → execute
    Invoke-Expression $cmd
}



function fkill {
    Get-Process |
        Select-Object Id, Name, CPU |
        fzf --prompt 'Kill> ' `
            --header 'ENTER: kill process' |
        ForEach-Object {
            $pidd = ($_ -split '\s+')[0]
            Stop-Process -Id $pidd -Force
        }
}
function fgb {
    $branch = git branch --all |
        fzf --prompt 'Branch> ' `
            --height 50% |
        ForEach-Object { $_.Trim() }

    if ($branch) {
        git switch ($branch -replace 'remotes/.+?/', '')
    }
}
function fgl {
    git log --oneline --decorate --color=always |
        fzf --ansi --height 80% `
            --preview 'git show --color=always {1}' `
            --prompt 'Log> '
}
function fcd {
    Get-ChildItem -Directory -Recurse -Depth 4 |
        Select-Object -Expand FullName |
        fzf --prompt 'CD> ' |
        Set-Location
}
function fenv {
    Get-ChildItem Env: |
        fzf --prompt 'Env> ' `
            --preview 'echo {}'
}
function fport {
    netstat -ano |
        fzf --prompt 'Port> '
}
function fapp {
    $paths = @()

    # 1. PATH executables
    $paths += $env:PATH -split ';'

    # 2. Common install locations
    $paths += @(
        "C:\Program Files",
        "C:\Program Files (x86)",
        "$env:LOCALAPPDATA\Programs"
    )

    # 3. Collect executables
    $apps = $paths |
        Where-Object { Test-Path $_ } |
        Get-ChildItem -Filter *.exe -Recurse -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty FullName |
        Sort-Object -Unique

    if (-not $apps) {
        Write-Error "No executables found"
        return
    }

    $pick = $apps |
        fzf --prompt 'Apps> ' `
            --style minimal `
            --border `
            --height 70% `
            --header 'ENTER: launch | CTRL-C: cancel'

    if (-not $pick) { return }

    Start-Process $pick
}
function fappc {
    $cache = "$env:TEMP\fapp-cache.txt"

    if (!(Test-Path $cache)) {
        Write-Host "Building executable cache..."
        $paths = @()
        $paths += $env:PATH -split ';'
        $paths += @(
            "C:\Program Files",
            "C:\Program Files (x86)",
            "$env:LOCALAPPDATA\Programs"
        )

        $paths |
            Where-Object { Test-Path $_ } |
            Get-ChildItem -Filter *.exe -Recurse -ErrorAction SilentlyContinue |
            Select-Object -ExpandProperty FullName |
            Sort-Object -Unique |
            Set-Content $cache
    }

    $pick = Get-Content $cache |
        fzf --prompt 'Apps> ' `
            --style minimal `
            --border `
            --height 70% `
            --header 'ENTER: launch | CTRL-R: rebuild cache'

    if (-not $pick) { return }

    Start-Process $pick
}

# function fapp-rebuild {
#     Remove-Item "$env:TEMP\fapp-cache.txt" -ErrorAction SilentlyContinue
#     fapp-cache
# }


function fev {
    $result = fzf `
        --prompt 'Everything> ' `
        --style minimal `
        --border `
        --height 70% `
        --header 'ENTER: open/cd | CTRL-O: nvim | CTRL-V: vscode' `
        --preview 'if exist "{}" (bat --color=always "{}" 2>nul)' `
        --bind 'start:reload:es.exe' `
        --bind 'change:reload:es.exe {q}' `
        --bind 'ctrl-o:execute(nvim "{}")' `
        --bind 'ctrl-v:execute(code "{}")'

    if (-not $result) { return }

    if (Test-Path $result -PathType Container) {
        Set-Location $result
    } else {
        Invoke-Item $result
    }
}


function fe {
    $result = fzf `
        --prompt 'Everything> ' `
        --style minimal `
        --border `
        --height 70% `
        --header 'ENTER: open/cd | CTRL-O: nvim | CTRL-V: vscode' `
        --preview 'if exist "{}" (bat --color=always "{}" 2>nul)' `
        --bind 'start:reload:es.exe !path:"*\$RECYCLE.BIN\*" !ext:lnk' `
        --bind 'change:reload:es.exe {q} !path:"*\$RECYCLE.BIN\*" !ext:lnk' `
        --bind 'ctrl-o:execute(nvim "{}")' `
        --bind 'ctrl-v:execute(code "{}")'

    if (-not $result) { return }

    if (Test-Path $result -PathType Container) {
        Set-Location $result
    } else {
        Invoke-Item $result
    }
}










