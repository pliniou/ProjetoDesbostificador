# =================================================================
# MÓDULO: BACKUP E RESTAURAÇÃO (Padrão Cebola Studios)
# =================================================================
function Invoke-BackupRestauracaoMenu {
    $title = "MÓDULO: BACKUP E RESTAURAÇÃO"
    $options = @(
        @{
            Name = 'Criar Ponto de Restauração do Sistema';
            Description = "Cria um 'save point' do Windows. É o botão de 'undo' para quando sua coragem superar seu bom senso.";
            Action = {
                Write-Host "`n[*] Criando um portal de fuga no tempo, também conhecido como Ponto de Restauração..." -ForegroundColor Yellow
                try {
                    $description = "Ponto criado pela Cebola Studios em $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
                    Checkpoint-Computer -Description $description -RestorePointType MODIFY_SETTINGS
                    Write-Host "V Ponto de restauração criado. Agora você pode ser um pouco mais imprudente." -ForegroundColor Green
                } catch {
                    Write-Host "X Falha ao criar o ponto de restauração. O sistema se recusa a criar uma rede de segurança." -ForegroundColor Red
                    Write-Host "  Verifique se a 'Proteção do Sistema' está ativada. Ou simplesmente prossiga sem ela. A escolha é sua." -ForegroundColor Yellow
                }
            }
        },
        @{
            Name = 'Criar Backup do Registro (HKLM e HKCU)';
            Description = 'Faz uma cópia do cérebro do Windows. Não garantimos que ele seja saudável para começar.';
            Action = {
                $backupDir = Join-Path -Path $env:USERPROFILE -ChildPath "Desktop\BackupRegistro_Cebola_$(Get-Date -Format 'yyyy-MM-dd_HH-mm')"
                if (-not (Test-Path $backupDir)) { New-Item -ItemType Directory -Path $backupDir -Force | Out-Null }
                Write-Host "`n[*] Fazendo o backup do Registro em '$backupDir'. Não perca esta pasta." -ForegroundColor Yellow
                try {
                    Start-Process reg.exe -ArgumentList "export HKLM `"$($backupDir)\HKLM_Backup.reg`" /y" -Wait -NoNewWindow
                    Start-Process reg.exe -ArgumentList "export HKCU `"$($backupDir)\HKCU_Backup.reg`" /y" -Wait -NoNewWindow
                    Write-Host "V Backup do Registro concluído. Guarde-o como se fosse seu bem mais precioso (provavelmente não é)." -ForegroundColor Green
                } catch {
                    Write-Host "X Ocorreu um erro. O Registro se recusa a ser copiado. Suspeito." -ForegroundColor Red
                }
            }
        },
        @{
            Name = 'Restaurar Backup do Registro';
            Description = 'Transplante de cérebro. Uma ação irreversível e potencialmente desastrosa. Prossiga com cautela.';
            Action = {
                $backupFile = Read-Host "`n[*] Forneça o caminho completo para o arquivo .reg. Sem erros de digitação, por favor"
                if ((Test-Path $backupFile -PathType Leaf) -and $backupFile.EndsWith(".reg")) {
                    Write-Host "`nAVISO: VOCÊ ESTÁ PRESTES A MODIFICAR O REGISTRO DE FORMA IRREVERSÍVEL." -ForegroundColor Red
                    $confirm = Read-Host "Se você tem certeza absoluta (o que é raro), digite 'S' para continuar"
                    if ($confirm.ToUpper() -eq 'S') {
                        Write-Host "`n[*] Importando registro. Se o PC travar, foi um prazer conhecê-lo." -ForegroundColor Yellow
                        Start-Process reg.exe -ArgumentList "import `"$backupFile`"" -Wait -NoNewWindow
                        Write-Host "V Registro (supostamente) restaurado. Recomendo fortemente reiniciar o computador e rezar." -ForegroundColor Green
                    } else {
                        Write-Host "Operação cancelada. Sábia decisão." -ForegroundColor Gray
                    }
                } else {
                    Write-Host "X Arquivo inválido ou não encontrado. Detalhes, meu caro, detalhes." -ForegroundColor Red
                }
            }
        },
        @{
            Name = 'Listar Pontos de Restauração Disponíveis';
            Description = 'Mostra seus "save points" anteriores. Veja de quantas maneiras você já quase quebrou o sistema.';
            Action = {
                $restorePoints = Get-ComputerRestorePoint
                if ($restorePoints) {
                    Write-Host "`n[*] Seus portais de fuga disponíveis são:" -ForegroundColor Cyan
                    $restorePoints | Format-Table SequenceNumber, CreationTime, Description -AutoSize
                } else {
                    Write-Host "Nenhum ponto de restauração encontrado. Você gosta de viver perigosamente, eu vejo." -ForegroundColor Yellow
                }
            }
        },
        @{
            Name = 'Voltar ao Menu Principal';
            Description = 'Retornar à segurança (relativa) do menu principal.';
            Action = { } # Ação vazia, o handler de menu cuidará do retorno.
        }
    )

    # Chama o handler de submenu genérico para gerenciar este menu.
    Invoke-SubMenuHandler -Options $options -Title $title
}