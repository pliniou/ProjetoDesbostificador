# =================================================================
# MÓDULO: PERSONALIZAÇÃO DA INTERFACE (Corrigido e Aprimorado)
# =================================================================
function Invoke-PersonalizacaoMenu {
    $title = "MÓDULO: PERSONALIZAÇÃO DA INTERFACE"
    # Flag para reiniciar o explorer.exe no final, se necessário.
    $explorerNeedsRestart = $false
    
    $options = @(
        @{
            Name = 'Ativar Modo Escuro para Apps e Sistema';
            Description = 'Para aqueles que preferem trabalhar nas sombras, como nós.';
            Action = {
                Write-Host "[*] Trazendo a escuridão..." -ForegroundColor Yellow
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0
                Write-Host "V Modo Escuro ativado. Seus olhos agradecem." -ForegroundColor Green
            }
        },
        @{
            Name = 'Restaurar Menu de Contexto Clássico (Botão Direito)';
            Description = 'Traz de volta o menu antigo, porque nem toda mudança é para melhor.';
            Action = {
                Write-Host "[*] Revertendo o menu de contexto à sua antiga glória..." -ForegroundColor Yellow
                $regPath = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"
                New-Item $regPath -Force | Out-Null
                Set-ItemProperty -Path $regPath -Name "(Default)" -Value "" -Force
                $script:explorerNeedsRestart = $true
                Write-Host "V Menu de contexto clássico restaurado. De nada." -ForegroundColor Green
            }
        },
        @{
            Name = 'Alinhar Barra de Tarefas à Esquerda';
            Description = 'Move os ícones para o canto, como a natureza pretendia.';
            Action = {
                Write-Host "[*] Movendo a barra de tarefas para seu lugar de direito..." -ForegroundColor Yellow
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Value 0
                $script:explorerNeedsRestart = $true
                Write-Host "V Barra de tarefas agora está devidamente alinhada à esquerda." -ForegroundColor Green
            }
        },
        @{
            Name = 'Mostrar Extensões de Arquivos Conhecidos';
            Description = 'Para que um .txt não finja ser um .exe. Segurança básica, pessoal.';
            Action = {
                Write-Host "[*] Revelando a verdadeira identidade dos arquivos..." -ForegroundColor Yellow
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0
                $script:explorerNeedsRestart = $true
                Write-Host "V Extensões de arquivo agora estão visíveis. Desconfie de tudo." -ForegroundColor Green
            }
        },
         @{
            Name = 'Desativar Widget de Notícias e Interesses';
            Description = 'Remove o botão de clima/notícias da barra de tarefas que ninguém pediu.';
            Action = {
                Write-Host "[*] Desativando o portal de distrações da barra de tarefas..." -ForegroundColor Yellow
                # O valor 0 desativa. O valor 1 ativa.
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Value 0
                $script:explorerNeedsRestart = $true
                Write-Host "V Widgets desativados. Menos uma coisa para te distrair." -ForegroundColor Green
            }
        },
        @{
            Name = 'Voltar ao Menu Principal';
            Description = 'Abortar missão e retornar à base.';
            Action = { } # Ação vazia.
        }
    )

    # Inicia o loop do menu
    $loop = $true
    while ($loop) {
        $script:explorerNeedsRestart = $false
        $selectedIndices = Show-Menu -Options $options -Title $title -MultiSelect $true
        
        if ($null -ne $selectedIndices -and $selectedIndices.Count -gt 0) {
            Clear-Host
            Write-Host "Aplicando suas... escolhas de design. Boa sorte." -ForegroundColor Cyan
            
            foreach ($index in $selectedIndices) {
                 if ($options[$index].Name -eq 'Voltar ao Menu Principal') {
                    $loop = $false
                    break
                }
                Write-Host "`n" + ("-"*60)
                & $options[$index].Action
            }

            if (-not $loop) { break }

            if ($script:explorerNeedsRestart) {
                Write-Host "`n[*] Suas alterações exigem um sacrifício. Reiniciando o Windows Explorer..." -ForegroundColor Yellow
                Stop-Process -Name explorer -Force
                Write-Host "V O Explorer foi reiniciado. Se algo sumiu, provavelmente não era importante." -ForegroundColor Green
            }
            Read-Host "`nPersonalizações aplicadas. Pressione Enter para continuar..."
        } else {
            $loop = $false
        }
    }
}