# =================================================================
# MÓDULO: REMOÇÃO DE BLOATWARE (Revisado e Granular)
# =================================================================
function Invoke-RemoverBloatwareMenu {
    $title = "MÓDULO: REMOÇÃO DE BLOATWARE"
    # Função interna para não repetir código. A Cebola Studios abomina a redundância.
    function Remove-AppGroup {
        param([string[]]$Patterns, [string]$GroupName)
        Write-Host "`n[*] Exterminando o grupo de Apps: '$GroupName'..." -ForegroundColor Yellow
        $totalRemoved = 0
        foreach ($pattern in $Patterns) {
            try {
                $packages = Get-AppxPackage -AllUsers -Name $pattern
                if ($packages) {
                    foreach ($package in $packages) {
                        Write-Host "  - Desinstalando: $($package.Name)" -ForegroundColor Gray
                        Remove-AppxPackage -Package $package.PackageFullName -AllUsers -ErrorAction SilentlyContinue
                        $totalRemoved++
                    }
                }
                $provisioned = Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -like $pattern }
                if ($provisioned) {
                    foreach ($prov in $provisioned) {
                        Write-Host "  - Removendo para futuros usuários: $($prov.DisplayName)" -ForegroundColor Gray
                        Remove-AppxProvisionedPackage -PackageName $prov.PackageName -Online -ErrorAction SilentlyContinue
                    }
                }
            } catch {}
        }
        Write-Host "V Operação no grupo '$GroupName' finalizada. $totalRemoved pacotes foram... persuadidos a sair." -ForegroundColor Green
    }

    $options = @(
        @{
            Name = 'Remover Apps de Jogos (Xbox, Game Bar, etc)';
            Description = 'Se você não usa o PC para jogar (ou usa a Steam), isso libera um espaço considerável.';
            Action = {
                $apps = @("*Xbox*", "*SolitaireCollection*")
                Remove-AppGroup -Patterns $apps -GroupName "Jogos"
            }
        },
        @{
            Name = 'Remover Apps de Mídia e Utilitários (Zune, 3D Viewer, etc)';
            Description = 'Coisas que pareciam uma boa ideia para a Microsoft, mas talvez não para você.';
            Action = {
                $apps = @("*ZuneMusic*", "*ZuneVideo*", "*3DViewer*", "*MixedReality.Portal*", "*Office.Lens*", "*OneNote*")
                Remove-AppGroup -Patterns $apps -GroupName "Mídia e Utilitários"
            }
        },
        @{
            Name = 'Remover Apps de Comunicação e Notícias (Mail, Skype, etc)';
            Description = 'Desinstala os comunicadores e agregadores de notícias que a Microsoft insiste em te empurrar.';
            Action = {
                $apps = @("*windowscommunicationsapps*", "*Messaging*", "*SkypeApp*", "*MicrosoftTeams*", "*YourPhone*", "*People*", "*BingNews*", "*BingWeather*")
                Remove-AppGroup -Patterns $apps -GroupName "Comunicação e Notícias"
            }
        },
        @{
            Name = 'Limpar Logs de Eventos do Windows';
            Description = 'Apaga o diário do Windows. Ele não precisa se lembrar de tudo o que você fez.';
            Action = {
                Write-Host "`n[*] Aplicando amnésia aos logs de eventos..." -ForegroundColor Yellow
                $logs = "Application", "Security", "System", "Setup"
                foreach ($log in $logs) {
                    if (Get-WinEvent -ListLog $log -ErrorAction SilentlyContinue) {
                        Clear-EventLog -LogName $log
                        Write-Host "  V Log '$log' agora é uma página em branco." -ForegroundColor Green
                    }
                }
            }
        },
        @{
            Name = 'Voltar ao Menu Principal';
            Description = 'Recuar estrategicamente.';
            Action = { $script:isSubMenu = $false }
        }
    )

    $script:isSubMenu = $true
    while ($script:isSubMenu) {
        $selectedIndices = Show-Menu -Options $options -Title $title -MultiSelect $true
        if ($null -ne $selectedIndices -and $selectedIndices.Count -gt 0) {
            Clear-Host
            Write-Host "Hora da faxina. Coloque suas luvas." -ForegroundColor Cyan
            foreach ($index in $selectedIndices) {
                if ($options[$index].Name -eq 'Voltar ao Menu Principal') {
                    & $options[$index].Action
                    break
                }
                Write-Host "`n" + ("-"*60)
                & $options[$index].Action
            }
            if ($script:isSubMenu) {
                Read-Host "`nLimpeza concluída. O sistema parece mais leve, ou é só impressão?"
            }
        } else {
            $script:isSubMenu = $false
        }
    }
}