# ==================================================================
# DESBOSTIFICADOR v1.0 - Uma Solução da Cebola Studios & Softwares
# "Otimizando sistemas com mais camadas que o esperado."
# ==================================================================
#
# Exige poderes de Administrador. Se não rodar, a culpa não é nossa.
# Tente de novo, mas desta vez, com mais privilégios.
#requires -RunAsAdministrator

# --- CARREGAMENTO DOS MÓDULOS ---
# Tentando carregar as engrenagens desta máquina...
try {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath 'Modules'
    if (-not (Test-Path -Path $modulePath)) {
        throw "Onde está a pasta 'Modules'? Não consigo trabalhar assim."
    }
    # Carregando cada função. Se algo quebrar, não fui eu.
    Get-ChildItem -Path $modulePath -Filter '*.ps1' | ForEach-Object { . $_.FullName }
    Write-Host "V Módulos carregados. Surpreendentemente, sem erros." -ForegroundColor Green
    Start-Sleep -Seconds 1
}
catch {
    Write-Host "X ERRO CRÍTICO: Parece que alguém tropeçou nos fios." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Read-Host "`nPressione Enter para sair e talvez repensar suas escolhas."
    exit
}

# --- FUNÇÕES DE UI (CEBOLA UI v1.1) ---

# Função de Menu Interativo. Nossa interface patenteada. Admire.
function Show-Menu {
    param (
        [Parameter(Mandatory = $true)] [array]$Options,
        [Parameter(Mandatory = $true)] [string]$Title,
        [bool]$MultiSelect = $false
    )
    $selectedIndexes = [System.Collections.Generic.HashSet[int]]::new()
    $currentIndex = 0
    $borderColor = "DarkCyan"
    $titleColor = "White"
    $selectedItemColor = "Black"
    $selectedItemBgColor = "Green"
    $normalItemColor = "White"

    do {
        Clear-Host
        Write-Host ("=" * 70) -ForegroundColor $borderColor
        Write-Host "  $($Title.ToUpper())" -ForegroundColor $titleColor
        Write-Host ("=" * 70) -ForegroundColor $borderColor
        Write-Host "  Use [↑][↓] para navegar. [Enter] para confirmar. [Esc] para voltar." -ForegroundColor Gray
        if ($MultiSelect) {
            Write-Host "  Use [Espaço] para marcar/desmarcar. Sim, é como mágica." -ForegroundColor Gray
        }
        Write-Host

        for ($i = 0; $i -lt $Options.Count; $i++) {
            $option = $Options[$i]
            $cursor = if ($i -eq $currentIndex) { "> " } else { "  " }
            $checkbox = if ($MultiSelect) { if ($selectedIndexes.Contains($i)) { "[x]" } else { "[ ]" } } else { "" }

            if ($i -eq $currentIndex) {
                Write-Host "$cursor$($checkbox) $($option.Name)" -ForegroundColor $selectedItemColor -BackgroundColor $selectedItemBgColor
            } else {
                Write-Host "$cursor$($checkbox) $($option.Name)" -ForegroundColor $normalItemColor
            }
        }

        $description = $Options[$currentIndex].Description
        if ($description) {
            Write-Host
            Write-Host ("-" * 70) -ForegroundColor $borderColor
            Write-Host "  O que isso faz (supostamente):" -ForegroundColor Yellow
            Write-Host "  $description" -ForegroundColor "Gray"
            Write-Host ("-" * 70) -ForegroundColor $borderColor
        }

        $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").VirtualKeyCode
        switch ($key) {
            13 { # Enter
                if (-not $MultiSelect) { return @($currentIndex) }
                break
            }
            32 { # Space
                if ($MultiSelect) {
                    if ($selectedIndexes.Contains($currentIndex)) { [void]$selectedIndexes.Remove($currentIndex) }
                    else { [void]$selectedIndexes.Add($currentIndex) }
                }
            }
            38 { if ($currentIndex -gt 0) { $currentIndex-- } } # Up Arrow
            40 { if ($currentIndex -lt ($Options.Count - 1)) { $currentIndex++ } } # Down Arrow
            27 { return $null } # Escape
        }
    } while ($key -ne 13)

    return ($selectedIndexes | Sort-Object)
}

# Handler genérico para submenus. Centraliza a lógica para não repetir código.
function Invoke-SubMenuHandler {
    param(
        [Parameter(Mandatory=$true)][array]$Options,
        [Parameter(Mandatory=$true)][string]$Title,
        [bool]$MultiSelect = $false
    )
    $loop = $true
    while ($loop) {
        $selectedIndices = Show-Menu -Options $options -Title $title -MultiSelect $MultiSelect
        
        if ($null -ne $selectedIndices -and $selectedIndices.Count -gt 0) {
            Clear-Host
            foreach ($index in $selectedIndices) {
                # A opção de voltar/sair sempre encerra o loop deste submenu
                if ($options[$index].Action.ToString() -match '\$script:isSubMenu = \$false' -or $options[$index].Name -match 'Voltar') {
                    $loop = $false
                    break
                }
                Write-Host "`n" + ("-"*60)
                & $options[$index].Action
            }

            if ($loop) {
                Read-Host "`nOperação concluída. Pressione Enter para voltar ao menu anterior..."
            }
        } else {
            $loop = $false
        }
    }
}


# --- MENU PRINCIPAL ---
function Show-MainMenu {
    $options = @(
        @{ Name = "Backup e Restauração"; Description = "O playground dos cautelosos. Crie uma rota de fuga antes de quebrar tudo."; Action = { Invoke-BackupRestauracaoMenu } },
        @{ Name = "Otimizações de Sistema"; Description = "Acelere sua máquina ou apenas ganhe um placebo de performance. Resultados podem variar."; Action = { Invoke-OtimizacaoSistemaMenu } },
        @{ Name = "Remoção de Bloatware"; Description = "Faça uma limpeza nos 'presentes' que a Microsoft deixou para você."; Action = { Invoke-RemoverBloatwareMenu } },
        @{ Name = "Instalação de Aplicativos"; Description = "Instale programas úteis sem ter que visitar 30 sites diferentes."; Action = { Invoke-InstalarAplicativosMenu } },
        @{ Name = "Personalização da Interface"; Description = "Faça o Windows parecer menos... padrão. Não prometemos bom gosto."; Action = { Invoke-PersonalizacaoMenu } },
        @{ Name = "Privacidade e Telemetria"; Description = "Diga ao sistema para cuidar da própria vida. Ou pelo menos, finja que ele obedece."; Action = { Invoke-PrivacidadeTelemetriaMenu } },
        @{ Name = "Sair"; Description = "Fecha o programa. Sentiremos sua falta (ou não)."; Action = { $script:continueLoop = $false } }
    )
    $osInfo = Get-CimInstance -ClassName Win32_OperatingSystem
    $title = "DESBOSTIFICADOR v1.0 | CEBOLA STUDIOS | $($osInfo.Caption)"
    $selectedIndex = Show-Menu -Options $options -Title $title
    
    if ($null -ne $selectedIndex) {
        & $options[$selectedIndex[0]].Action
    } else {
        # Se o usuário pressionar Esc no menu principal, considera-se a intenção de sair.
        $script:continueLoop = $false
    }
}

# --- LOOP PRINCIPAL DO SCRIPT ---
$script:continueLoop = $true
do {
    Show-MainMenu
} until (-not $script:continueLoop)

Clear-Host
Write-Host "Cebola Studios agradece. Ou algo assim. Volte sempre." -ForegroundColor Green
Start-Sleep -Seconds 3