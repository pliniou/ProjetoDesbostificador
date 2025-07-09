# =================================================================
# MÓDULO: PRIVACIDADE E TELEMETRIA (Padrão Cebola Studios)
# =================================================================
function Invoke-PrivacidadeTelemetriaMenu {
    $title = "MÓDULO: PRIVACIDADE E TELEMETRIA"
    
    # Função interna para não repetir código.
    function Set-RegistryValueSecurely {
        param($Path, $Name, $Value)
        try {
            if (-not (Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null }
            Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type DWord -Force -ErrorAction Stop
            return $true
        } catch { return $false }
    }

    $options = @(
        @{
            Name = 'Desativar Telemetria Principal (DataCollection)';
            Description = "Impede o envio de 'feedback anônimo'. Pisque duas vezes se você acredita que é anônimo.";
            Action = {
                Write-Host "`n[*] Cortando o principal canal de fofocas do Windows..." -ForegroundColor Yellow
                if (Set-RegistryValueSecurely -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0) {
                    Write-Host "  V Telemetria principal silenciada. O sistema agora está (um pouco mais) no escuro." -ForegroundColor Green
                } else {
                    Write-Host "  X Falha ao silenciar a telemetria. Ela realmente quer ser ouvida." -ForegroundColor Red
                }
            }
        },
        @{
            Name = 'Desativar Serviços de Rastreamento e Diagnóstico';
            Description = 'Corta alguns dos tentáculos de rastreamento do sistema (DiagTrack, etc).';
            Action = {
                Write-Host "`n[*] Colocando uma mordaça nos serviços de diagnóstico..." -ForegroundColor Yellow
                $servicesToDisable = @("DiagTrack", "dmwappushservice", "diagnosticshub.standardcollector.service")
                foreach ($serviceName in $servicesToDisable) {
                    try {
                        $service = Get-Service -Name $serviceName -ErrorAction Stop
                        Set-Service -Name $serviceName -StartupType Disabled -ErrorAction Stop
                        Write-Host "  V Serviço '$serviceName' agora está em silêncio sepulcral." -ForegroundColor Green
                    } catch {
                        Write-Host "  - Serviço '$serviceName' não foi encontrado. Provavelmente já estava se escondendo." -ForegroundColor DarkGray
                    }
                }
            }
        },
        @{
            Name = 'Desativar Cortana';
            Description = 'Coloca a Cortana para dormir. Permanentemente.';
            Action = {
                Write-Host "`n[*] Desativando a assistente que ninguém pediu..." -ForegroundColor Yellow
                Set-RegistryValueSecurely -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Value 0
                Set-RegistryValueSecurely -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 0
                Set-RegistryValueSecurely -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Value 0
                Write-Host "  V Cortana foi desativada. O silêncio é reconfortante." -ForegroundColor Green
            }
        },
        @{
            Name = 'Desativar Relatórios de Erro do Windows (WER)';
            Description = 'Impede o Windows de contar para a Microsoft toda vez que ele tropeça e cai.';
            Action = {
                Write-Host "`n[*] Ensinando o Windows a não lavar roupa suja em público..." -ForegroundColor Yellow
                $path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting"
                Set-RegistryValueSecurely -Path $path -Name "Disabled" -Value 1
                Set-RegistryValueSecurely -Path $path -Name "DontSendAdditionalData" -Value 1
                Write-Host "  V Relatórios de Erro agora guardarão seus segredos." -ForegroundColor Green
            }
        },
        @{
            Name = 'Voltar ao Menu Principal';
            Description = 'Sair da toca e voltar para o menu principal.';
            Action = { $script:isSubMenu = $false }
        }
    )

    $script:isSubMenu = $true
    while ($script:isSubMenu) {
        $selectedIndices = Show-Menu -Options $options -Title $title -MultiSelect $true
        if ($null -ne $selectedIndices -and $selectedIndices.Count -gt 0) {
            Clear-Host
            Write-Host "Hora de colocar o chapéu de papel alumínio. Aplicando filtros de privacidade." -ForegroundColor Cyan
            foreach ($index in $selectedIndices) {
                 if ($options[$index].Name -eq 'Voltar ao Menu Principal') {
                    & $options[$index].Action
                    break
                }
                Write-Host "`n" + ("-"*60)
                & $options[$index].Action
            }
            if ($script:isSubMenu) {
                Read-Host "`nConfigurações de privacidade aplicadas. Você está agora um pouco mais invisível."
            }
        } else {
            $script:isSubMenu = $false
        }
    }
}