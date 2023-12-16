if (!(Get-Module -Name PSReadline))
{
    Install-Module PSReadline
}

function Get-GitBranch
{
    $branch = & git rev-parse --abbrev-ref HEAD 2>$null
    if ($branch)
    {
        return " ($branch)"
    }
    return ""
}


# Set-PSReadLineKeyHandler -Chord Ctrl+n HistorySearchForward
# Set-PSReadLineKeyHandler -Chord Ctrl+p HistorySearchBackward
Set-Alias -Name vim -Value nvim
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineKeyHandler -Chord Ctrl+n ViTabCompleteNext
Set-PSReadLineKeyHandler -Chord Ctrl+p ViTabCompletePrevious
Set-PSReadLineKeyHandler -Chord Ctrl+f ViSearchHistoryBackward
Set-PSReadLineKeyHandler -Chord Ctrl+l ViNextWord
Set-PSReadLineKeyHandler -Chord Ctrl+h ViBackwardWord
Set-PSReadLineKeyHandler -Chord Ctrl+w BackwardDeleteWord

if ($PSEdition -eq "Core") # PowerShell(pwsh.exe)
{
    Set-PSReadLineKeyHandler -Chord Ctrl+Oem4 -Function ViCommandMode

    $Global:FirstSep = "┎"
    $Global:SecondSep = "┖"
    # Return a blank prompt and let Write-Host handle everything
    function prompt
    {
        Write-Host "$($Global:PSStyle.Foreground.FromRgb(102, 0, 0))${FirstSep} " -NoNewline 
        Write-Host "$($Global:PSStyle.Foreground.FromRgb(132, 65, 45))$env:USERNAME" -NoNewline  
        Write-Host "$($Global:PSStyle.Foreground.FromRgb(64, 64, 64))@" -NoNewline  
        Write-Host "$($Global:PSStyle.Foreground.FromRgb(128, 106, 0))$(hostname)" -NoNewline  
        Write-Host "$($Global:PSStyle.Foreground.FromRgb(64, 64, 64)):" -NoNewline 
        Write-Host "$($Global:PSStyle.Foreground.FromRgb(0,106,128))${PWD} " -NoNewline
        Write-Host "$($Global:PSStyle.Foreground.FromRgb(204, 0, 0))$(Get-GitBranch)" 
        Write-Host "$($Global:PSStyle.Foreground.FromRgb(102, 0, 0))${SecondSep}" -NoNewline 
        Write-Host "$($Global:PSStyle.Foreground.FromRgb(64, 64, 64)) $" -NoNewline 
        # return "$($Global:PSStyle.Foreground.FromRgb(102, 0, 0))┖$($Global:PSStyle.Foreground.FromRgb(64, 64, 64)) $ "
        return "$($Global:PSStyle.Foreground.FromRgb(160, 160, 160)) "
    }

    # Logging
    if ($IsWindows) 
    {
        $TranscriptDir = "E:\Coding\PowerShell\Transcripts\"
    } elseif ($IsLinux -or $IsMacOS) 
    {
        $TranscriptDir = "~/.transcripts"
    }

    if (!($TranscriptDir))
    {
        New-Item $TranscriptDir -Type Directory -Force
    }

    $TranscriptLog = (hostname) + "_" + $env:USERNAME + "_"+(Get-Date -UFormat "%d-%m-%Y")
    $TranscriptPath = $TranscriptDir + $TranscriptLog
    Start-Transcript -LiteralPath $TranscriptPath -Append

    ######################/* PSReadLineOption Color Tokens */######################
    # PSReadLineOption -Colors {Hash Table}. Escape with `e for pwsh, $([char]0x1b) for powershell.exe (5.x)
    $colors = @{
        "Number"                    = "`e[38;5;39m"     # The number token color.
        "Error"                     = "`e[38;5;1m"      # The error color. 
        "Emphasis"                  = "`e[38;5;200m"    # The emphasis color. 
        "Selection"                 = "`e[38;5;250m"    # The color to highlight the menu selection or selected text.
        "Default"                   = "`e[38;5;254m"    # The default token color.
        "Comment"                   = "`e[38;5;244m"    # The comment token color.
        "Keyword"                   = "`e[38;5;45m"     # The keyword token color.
        "String"                    = "`e[38;5;113m"    # The string token color.
        "Operator"                  = "`e[38;5;206m"    # The operator token color.
        "Variable"                  = "`e[38;5;82m"     # The variable token color.
        "Command"                   = "`e[38;5;208m"    # The command token color.
        "Parameter"                 = "`e[38;5;111m"    # The parameter token color.
        "Type"                      = "`e[38;5;171m"    # The type token color.
        "Member"                    = "`e[38;5;150m"    # The member name token color.
        "InlinePrediction"          = "`e[38;5;240m"    # The color for the inline view of the predictive suggestion.
        "ListPrediction"            = "`e[38;5;53m"     # The color for the leading `>` character and prediction source name.
        "ListPredictionSelected"    = "`e[38;5;128m"    # The color for the selected prediction in list view.
        "ContinuationPrompt"        = "`e[38;5;255m"    # The color of the continuation prompt.
    }
    Set-PSReadLineOption -Colors $colors
    Write-Output "Setup loaded for PowerShell Core Edition."

} 
