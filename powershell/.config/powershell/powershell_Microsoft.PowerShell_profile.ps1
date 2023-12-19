
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
Set-PSReadLineKeyHandler -Chord Ctrl+w BackwardDeleteWord
Set-PSReadLineKeyHandler -Chord Ctrl+n ViTabCompleteNext
Set-PSReadLineKeyHandler -Chord Ctrl+p ViTabCompletePrevious
Set-PSReadLineKeyHandler -Chord Ctrl+f ViSearchHistoryBackward
Set-PSReadLineKeyHandler -Chord Ctrl+l ViNextWord
Set-PSReadLineKeyHandler -Chord Ctrl+h ViBackwardWord
Set-Alias -Name vim -Value nvim
Set-Alias -Name vi  -Value nvim
Set-PSReadLineOption -EditMode Vi
if ($PSEdition -eq "Desktop") # Windows PowerShell(powershell.exe)
{

    Set-PSReadLineKeyHandler -Chord Ctrl+[ -Function ViCommandMode

    $BURNT_ORANGE="$([char]0x1b)[38;5;130m"
    $DARK_YELLOW="$([char]0x1b)[38;5;58m"
    $GREY="$([char]0x1b)[38;5;241m"
    $MUTED_BLUEGREEN="$([char]0x1b)[38;5;30m"
    $RED_256="$([char]0x1b)[38;5;160m"
    $RESET="$([char]0x1b)[0m"

    $DARK_RED="$([char]0x1b)[38;5;88m"
    $SEP_COLOR=${DARK_RED}
    
    $NAME_COLOR=${DARK_YELLOW};
    $HOST_COLOR=${BURNT_ORANGE};
    $PATH_COLOR=${MUTED_BLUEGREEN};
    # $YELLOW="$([char]0x1b)[38;5;214m"
    # $VENV_COLOR=${YELLOW}

    function prompt
    {
        # Return a blank prompt to let Write-Host handle everything
        Write-Host "${SEP_COLOR}${FIRST_SEP} " -NoNewline 
        Write-Host "${NAME_COLOR}$env:USERNAME" -NoNewline 
        Write-Host "${GREY}@" -NoNewline 
        Write-Host "${HOST_COLOR}$(hostname)" -NoNewline 
        Write-Host "${GREY}:" -NoNewline 
        Write-Host "${PATH_COLOR}${PWD}" -NoNewline
        Write-Host "${RED_256}$(Get-GitBranch)" -NoNewline
        Write-Host "${SEP_COLOR}${SECOND_SEP}" -NoNewline 
        Write-Host "${GREY} $" -NoNewline
        return " ${RESET}"

    }

    # Logging
    $TranscriptDir = "E:\Coding\PowerShell\Transcripts\"
    $TranscriptLog = "WindowsPowershell_$(hostname)_${env:USERNAME}_" + (Get-Date -UFormat "%d-%m-%Y") 
    $TranscriptPath = $TranscriptDir + $TranscriptLog
    Start-Transcript -LiteralPath $TranscriptPath -Append

    ######################/* PSReadLineOption Color Tokens */######################
    # PSReadLineOption -Colors Hash Table. `e for pwsh.exe (7.x), $([char]0x1b) for powershell.exe (5.x)
    $colors = @{
        "Number"                    = "$([char]0x1b)[38;5;39m"     # The number token color.
        "Error"                     = "$([char]0x1b)[38;5;1m"      # The error color. 
        "Emphasis"                  = "$([char]0x1b)[38;5;200m"    # The emphasis color. 
        "Selection"                 = "$([char]0x1b)[38;5;245m"    # The color to highlight the menu selection or selected text.
        "Default"                   = "$([char]0x1b)[38;5;254m"    # The default token color.
        "Comment"                   = "$([char]0x1b)[38;5;244m"    # The comment token color.
        "Keyword"                   = "$([char]0x1b)[38;5;45m"     # The keyword token color.
        "String"                    = "$([char]0x1b)[38;5;113m"    # The string token color.
        "Operator"                  = "$([char]0x1b)[38;5;206m"    # The operator token color.
        "Variable"                  = "$([char]0x1b)[38;5;82m"     # The variable token color.
        "Command"                   = "$([char]0x1b)[38;5;208m"    # The command token color.
        "Parameter"                 = "$([char]0x1b)[38;5;111m"    # The parameter token color.
        "Type"                      = "$([char]0x1b)[38;5;171m"    # The type token color.
        "Member"                    = "$([char]0x1b)[38;5;150m"    # The member name token color.
        "InlinePrediction"          = "$([char]0x1b)[38;5;240m"    # The color for the inline view of the predictive suggestion.
        "ListPrediction"            = "$([char]0x1b)[38;5;53m"     # The color for the leading `>` character and prediction source name.
        "ListPredictionSelected"    = "$([char]0x1b)[38;5;128m"    # The color for the selected prediction in list view.
        "ContinuationPrompt"        = "$([char]0x1b)[38;5;238m"    # The color of the continuation prompt.
    }
    Set-PSReadLineOption -Colors $colors
    Write-Output "Setup loaded for PowerShell Desktop Edition."
}


