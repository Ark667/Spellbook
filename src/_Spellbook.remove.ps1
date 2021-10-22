
$env:SPELLBOOK_CONFIG_FILE = $null
$env:SPELLBOOK_SPELLS_PATH = $null 
$env:SPELLBOOK_HISTORY_FILE = $null

$global:spells = $null

 Remove-Item -Path Function:\Show-Spellbook
 Remove-Item -Path Function:\Update-Spellbook
 Remove-Item -Path Function:\Debug-Spellbook
 Remove-Item -Path Function:\Trace-Spellbook
 
 Remove-Item -Path Alias:\Spellbook-Index
 Remove-Item -Path Alias:\Spellbook-Update
 Remove-Item -Path Alias:\Spellbook-Help
 Remove-Item -Path Alias:\Spellbook-History

 # TODO: remove spell functions