
Write-Host
@"
     ▄████████    ▄███████▄    ▄████████  ▄█        ▄█       ▀█████████▄   ▄██████▄   ▄██████▄     ▄█   ▄█▄ 
    ███    ███   ███    ███   ███    ███ ███       ███         ███    ███ ███    ███ ███    ███   ███ ▄███▀ 
    ███    █▀    ███    ███   ███    █▀  ███       ███         ███    ███ ███    ███ ███    ███   ███▐██▀   
    ███          ███    ███  ▄███▄▄▄     ███       ███        ▄███▄▄▄██▀  ███    ███ ███    ███  ▄█████▀    
  ▀███████████ ▀█████████▀  ▀▀███▀▀▀     ███       ███       ▀▀███▀▀▀██▄  ███    ███ ███    ███ ▀▀█████▄    
           ███   ███          ███    █▄  ███       ███         ███    ██▄ ███    ███ ███    ███   ███▐██▄   
     ▄█    ███   ███          ███    ███ ███▌    ▄ ███▌    ▄   ███    ███ ███    ███ ███    ███   ███ ▀███▄ 
   ▄████████▀   ▄████▀        ██████████ █████▄▄██ █████▄▄██ ▄█████████▀   ▀██████▀   ▀██████▀    ███   ▀█▀ 
                                         ▀         ▀                                              ▀         
https://github.com/Ark667/Spellbook
"@

# Load helper functions
Import-Module "$(Join-Path -Path $PSScriptRoot -ChildPath _Spellbook.helper.ps1)" -Force

# Store current path of this script
$env:SPELLBOOK_CONFIG_FILE = $MyInvocation.MyCommand.Path
if ( $null -eq $env:SPELLBOOK_SPELLS_PATH ) { $env:SPELLBOOK_SPELLS_PATH = Force-Resolve-Path "$(Split-Path -Path $env:SPELLBOOK_CONFIG_FILE)/../data" }
if ( $null -eq $env:SPELLBOOK_HISTORY_FILE ) { $env:SPELLBOOK_HISTORY_FILE = Force-Resolve-Path "$(Split-Path -Path $env:SPELLBOOK_CONFIG_FILE)/../log/History.txt" }
Ensure-Path $(Split-Path -Path $env:SPELLBOOK_HISTORY_FILE)

# Load knowledge base
$global:spells = $null
foreach ($file In (Get-ChildItem ($env:SPELLBOOK_SPELLS_PATH)*.yaml)) {
	$knowledge = $(Get-Content $file | ConvertFrom-Yaml).spellbook.spells.spell
	if ( $knowledge.Count -gt 0 ) { $global:spells = $global:spells + $knowledge }
}

# Print spellbook index
function global:Show-Spellbook {
	param([string]$filter)
	 $spells | 
	 	ForEach-Object { $o = New-Object -TypeName PSCustomObject -Property @{Alias=$_.alias;Name=$_.name;Level=$_.level;School=$_.school;Tags="$($_.tags)"}; $o } | 
		Where-Object { $_.School -like "*$filter*" -or $_.Tags -like "*$filter*" } | 
		Sort-Object -Property Level | 
		Format-Table
}
Register-ArgumentCompleter -CommandName Show-Spellbook -ParameterName filter -ScriptBlock { $spells.tags | Sort-Object | Get-Unique }
Set-Alias Spellbook-Index 'Show-Spellbook' -Scope global

# Update spellbook
function global:Update-Spellbook {
	Invoke-Expression $env:SPELLBOOK_CONFIG_FILE
}
Set-Alias Spellbook-Update 'Update-Spellbook' -Scope global

# Spell help
function global:Debug-Spellbook {
	param([string]$spell)
	Get-Help $spell
	Write-Host "$(($spells | Where-Object { $_.name -eq $spell } | Select-Object command).command)`n" -ForegroundColor Blue
}
Register-ArgumentCompleter -CommandName Debug-Spellbook -ParameterName spell -ScriptBlock { $spells.name | Sort-Object | Get-Unique }
Set-Alias Spellbook-Help 'Debug-Spellbook' -Scope global

# Spells history
function global:Trace-Spellbook {
	Write-Host "`nCast history!`n" -ForegroundColor Yellow
	Get-Content $env:SPELLBOOK_HISTORY_FILE
	Write-Host "$env:SPELLBOOK_HISTORY_FILE`n" -ForegroundColor Blue
}
Set-Alias Spellbook-History 'Trace-Spellbook' -Scope global

# Register every spell as function
foreach ($spell In $spells) {

	# Setup basic command
	$command = 
	"function global:$($spell.name) {
		<#
		.SYNOPSIS
		$($spell.synopsis)
		.DESCRIPTION
		$($spell.remarks)
		.ALIASES
		$($spell.alias)
		#>
		param({parameters})

		# Execute spell
		`$cmd = `"$($spell.command -replace '"', '``"')`"

		# Execution start info
		Write-Host `"``nCasting Spell...`" -ForegroundColor Yellow
		Write-Host `"`$cmd``n`" -ForegroundColor DarkGray

		# Execute process and measure time
		`$seconds = (Measure-Command { Invoke-Expression `"& `$cmd`" | Out-Default }).TotalSeconds

		# Execution end info
		Write-Host `"``nFinished!`" -ForegroundColor Yellow		
		`$json = `"`$(ConvertTo-Json (New-Object -TypeName PSCustomObject -Property @{ name=`$MyInvocation.Line;command=`$cmd;date=`$(get-date -Format `"yyyy/MM/dd HH:mm:ss`");success=`$?;time=`$seconds }))``n`"	
		`$jobj = ConvertFrom-Json -InputObject `$json
		Write-Host `"`$(ConvertTo-Json `$jobj)``n`" -ForegroundColor DarkGray

		# Log executed command
		`"`$(get-date -Format `"yyyy/MM/dd HH:mm:ss`")`t`$(`$MyInvocation.Line)`" >> `$env:SPELLBOOK_HISTORY_FILE
		`"``t`$cmd`n`" >> `$env:SPELLBOOK_HISTORY_FILE
	}"
	
	# Setup parameters
	$paramsDefinition = $null
	foreach ($parameter In $spell.parameters.parameter) {

		# Required or defaulted
		$paramDefinition = "[Parameter(Mandatory=`$true)][String]`$$($parameter.name)"
		if ( -not ( $null -eq $parameter.default ) ) 
		{ 
			$paramDefinition = "[Parameter(Mandatory=`$false)][String]`$$($parameter.name)=`"$($parameter.default)`"" 

			# Completer with default parameter value
			$scriptBlock = [Scriptblock]::Create("Write-Output `"`$((((`$spells | Where-Object { `$_.name -eq `"$($spell.name)`" } | Select-Object parameters).parameters | Select-Object parameter).parameter | Where-Object { `$_.name -eq `"$($parameter.name)`" }).default)`"")		
			Register-ArgumentCompleter -CommandName "$($spell.name)" -ParameterName "$($parameter.name)" -ScriptBlock $scriptBlock
		}
		if ( "cli" -eq $parameter.type ) { $paramDefinition = "[Parameter(ValueFromRemainingArguments=`$true)][String]`$$($parameter.name)" }

		$paramsDefinition = $paramsDefinition, $paramDefinition -join ", " -replace '^, '
		$command = $command -replace "<$($parameter.name)>", "`$$($parameter.name)"	
	}
	$command = $command -replace "<random>", "`$(Get-Random 9999)"	
	$command = $command -replace "{parameters}", "$paramsDefinition"

	Invoke-Expression -Command $command 

	# Alias for command if configured
	if ( -not ( $null -eq $spell.alias ) ) { Set-Alias -Name $spell.alias -Value $spell.name -Scope global }
}

Write-Host "$PWD>Spellbook-Index`n" -ForegroundColor Blue
