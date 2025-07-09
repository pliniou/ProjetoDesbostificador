# =================================================================
# MÓDULO: OTIMIZAÇÕES DE SISTEMA (Revisado e Expandido)
# =================================================================
function Invoke-OtimizacaoSistemaMenu {
    $title = "MÓDULO: OTIMIZAÇÕES DE SISTEMA"
    $options = @(
        @{
            Name = 'Ativar Plano de Energia de "Alto Desempenho"';
            Description = 'Configura o Windows para consumir energia como se não houvesse amanhã, em troca de performance.';
            Action = {
                Write-Host "`n[*] Forçando o modo de 'Alto Desempenho'. Segure-se." -ForegroundColor Yellow
                $highPerformanceGuid = "8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c"
                powercfg /setactive $highPerformanceGuid
                Write-Host "V Plano de energia 'Alto Desempenho' ativado. A conta de luz é por sua conta." -ForegroundColor Green
            }
        },
        @{
            Name = 'Desativar Efeitos Visuais (Foco em Desempenho)';
            Description = 'Faz o Windows parecer que voltou a 2001, mas pode deixá-lo um pouco mais rápido.';
            Action = {
                Write-Host "`n[*] Removendo o brilho e o glamour da interface..." -ForegroundColor Yellow
                # Desativa o serviço de Temas
                try {
                    Set-Service -Name "Themes" -StartupType Disabled; Stop-Service -Name "Themes" -Force
                } catch {}
                # Ajusta para melhor desempenho via registro
                $regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects"
                Set-ItemProperty -Path $regPath -Name "VisualFx" -Value 2
                Write-Host "V Efeitos visuais desativados. Bem-vindo à era da velocidade bruta." -ForegroundColor Green
            }
        },
        @{
            Name = 'Desativar Serviços Desnecessários (Fax, Spooler, etc)';
            Description = 'Dispensa funcionários (serviços) que raramente fazem algo útil.';
            Action = {
                $servicesToDisable = @("Fax", "Spooler", "MapsBroker", "lfsvc")
                Write-Host "`n[*] Desativando serviços que provavelmente você nem sabia que existiam..." -ForegroundColor Yellow
                foreach ($serviceName in $servicesToDisable) {
                    try {
                        $service = Get-Service -Name $serviceName -ErrorAction Stop
                        if ($service.StartType -ne 'Disabled') {
                            Stop-Service -Name $serviceName -Force -ErrorAction SilentlyContinue
                            Set-Service -Name $serviceName -StartupType Disabled -ErrorAction Stop
                            Write-Host "  V Serviço '$serviceName' foi convidado a se retirar." -ForegroundColor Green
                        } else {
                            Write-Host "  - Serviço '$serviceName' já estava no ostracismo." -ForegroundColor DarkGray
                        }
                    } catch {
                        Write-Host "  - Serviço '$serviceName' não encontrado. Menos um para demitir." -ForegroundColor DarkGray
                    }
                }
            }
        },
        @{
            Name = 'Desativar Superfetch / SysMain';
            Description = 'Impede o Windows de tentar adivinhar o que você vai fazer. Útil em SSDs.';
            Action = {
                Write-Host "`n[*] Pedindo ao SysMain para parar de ser tão... proativo." -ForegroundColor Yellow
                try {
                    $service = Get-Service -Name "SysMain" -ErrorAction Stop
                    if ($service.StartType -ne 'Disabled') {
                        Set-Service -Name "SysMain" -StartupType Disabled -ErrorAction Stop
                        Write-Host "  V Serviço 'SysMain' foi devidamente contido." -ForegroundColor Green
                    } else {
                        Write-Host "  - Serviço 'SysMain' já estava quieto no seu canto." -ForegroundColor DarkGray
                    }
                } catch {
                     Write-Host "  - Serviço 'SysMain' não foi encontrado. Sorte a sua." -ForegroundColor DarkGray
                }
            }
        },
        @{
            Name = 'Limpeza de Arquivos Temporários';
            Description = 'Joga fora o lixo digital que o sistema acumula nos cantos.';
            Action = {
                Write-Host "`n[*] Fazendo a faxina nos arquivos temporários..." -ForegroundColor Yellow
                $tempPaths = @("$env:TEMP", "$env:windir\Temp")
                foreach ($path in $tempPaths) {
                    if (Test-Path $path) {
                        Write-Host "  - Esvaziando: $path" -ForegroundColor Gray
                        Remove-Item -Path (Join-Path $path "*") -Recurse -Force -ErrorAction SilentlyContinue
                    }
                }
                 Write-Host "V Arquivos temporários? Que arquivos?" -ForegroundColor Green
            }
        },
        @{
            Name = 'Limpar Cache do Windows Update';
            Description = 'Libera espaço removendo arquivos de instalação de atualizações antigas.';
            Action = {
                Write-Host "`n[*] Removendo os restos mortais de atualizações passadas..." -ForegroundColor Yellow
                Stop-Service -Name "wuauserv" -Force -ErrorAction SilentlyContinue
                $path = "$env:windir\SoftwareDistribution"
                if(Test-Path $path){
                    Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue
                }
                Start-Service -Name "wuauserv"
                Write-Host "V Cache do Windows Update limpo. O sistema agradece." -ForegroundColor Green
            }
        },
        @{
            Name = 'Voltar ao Menu Principal';
            Description = 'Fugir para as colinas. Digo, para o menu anterior.';
            Action = { $script:isSubMenu = $false }
        }
    )

    $script:isSubMenu = $true
    while ($script:isSubMenu) {
        $selectedIndices = Show-Menu -Options $options -Title $title -MultiSelect $true
        if ($null -ne $selectedIndices -and $selectedIndices.Count -gt 0) {
            Clear-Host
            Write-Host "Iniciando otimizações. Se algo explodir, não nos responsabilizamos." -ForegroundColor Cyan
            foreach ($index in $selectedIndices) {
                # Evita que a opção 'Voltar' seja executada no loop
                if ($options[$index].Name -eq 'Voltar ao Menu Principal') {
                    & $options[$index].Action
                    break
                }
                Write-Host "`n" + ("-"*60)
                & $options[$index].Action
            }
            if ($script:isSubMenu) {
                Read-Host "`nOtimizações (supostamente) concluídas. Pressione Enter para continuar sua jornada."
            }
        } else {
            $script:isSubMenu = $false
        }
    }
}