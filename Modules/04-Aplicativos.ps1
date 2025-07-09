# =================================================================
# MÓDULO: INSTALAÇÃO DE APLICATIVOS (Padrão Cebola Studios)
# =================================================================
function Invoke-InstalarAplicativosMenu {
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Host "X O comando 'winget' não foi encontrado." -ForegroundColor Red
        Write-Host "Sem ele, este módulo é apenas um monte de texto inútil." -ForegroundColor Yellow
        $installWinget = Read-Host "`nDeseja que a gente tente instalar o winget para você? (S/N)"
        if ($installWinget -eq 'S') {
            # O código para instalar o winget permanece o mesmo, é uma operação delicada.
            # Não há espaço para ironia quando se instala a ferramenta principal.
            try {
                Write-Host "[*] Baixando e instalando o App Installer (que inclui o winget)..." -ForegroundColor Yellow
                $wingetUrl = "https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
                $installerPath = Join-Path $env:TEMP "winget-installer.msixbundle"
                Invoke-WebRequest -Uri $wingetUrl -OutFile $installerPath -UseBasicParsing -ErrorAction Stop
                Add-AppxPackage -Path $installerPath -ErrorAction Stop
                Remove-Item -Path $installerPath -Force -ErrorAction SilentlyContinue
                Write-Host "V Winget instalado com sucesso! Por favor, reinicie o script para usá-lo." -ForegroundColor Green
            } catch {
                Write-Host "X Falha ao instalar o winget: $($_.Exception.Message)" -ForegroundColor Red
            }
        }
        Read-Host "Pressione Enter para continuar..."
        return
    }

    $categories = @{
        "Navegadores"   = @( @{ Name = 'Google Chrome'; ID = 'Google.Chrome'; Description = 'O navegador que consome mais RAM que seus jogos.' }, @{ Name = 'Mozilla Firefox'; ID = 'Mozilla.Firefox'; Description = 'O navegador preferido de quem diz que se preocupa com a privacidade.' }, @{ Name = 'Brave Browser'; ID = 'Brave.Brave'; Description = 'Navegador que bloqueia anúncios para te mostrar os anúncios dele.' } );
        "Utilitários"   = @( @{ Name = '7-Zip'; ID = '7zip.7zip'; Description = 'Compactador de arquivos com uma interface que parou no tempo, mas funciona.' }, @{ Name = 'WinRAR'; ID = 'RARLab.WinRAR'; Description = 'O eterno trial que todo mundo usa.' }, @{ Name = 'Everything'; ID = 'voidtools.Everything'; Description = 'Encontra seus arquivos mais rápido do que você consegue perdê-los.' } );
        "Mídia"         = @( @{ Name = 'VLC Media Player'; ID = 'VideoLAN.VLC'; Description = 'O cone laranja que roda até vídeo de calculadora.' }, @{ Name = 'Spotify'; ID = 'Spotify.Spotify'; Description = 'Sua trilha sonora para fingir que está trabalhando.' } );
        "Desenvolvimento" = @( @{ Name = 'Visual Studio Code'; ID = 'Microsoft.VisualStudioCode'; Description = 'Onde você passa mais tempo configurando extensões do que codificando.' }, @{ Name = 'Git'; ID = 'Git.Git'; Description = 'A ferramenta que permite que você quebre tudo e depois volte no tempo.' }, @{ Name = 'Python 3'; ID = 'Python.Python.3'; Description = 'Tão simples que até seu chefe acha que consegue programar.' } )
    }

    # Menu de Categoria
    $categoryOptions = $categories.Keys | ForEach-Object { @{ Name = $_; Description = "Ver a lista de apps para '$ Mit-Beschreibungen'" } }
    $categoryOptions += @{ Name = "Voltar"; Description = "Voltar ao menu principal." }
    $selectedCategoryIndex = Show-Menu -Options $categoryOptions -Title "ESCOLHA UMA CATEGORIA DE APPS"
    if ($null -eq $selectedCategoryIndex -or $categoryOptions[$selectedCategoryIndex[0]].Name -eq "Voltar") { return }
    
    $selectedCategoryName = $categoryOptions[$selectedCategoryIndex[0]].Name
    $appsInCategory = $categories[$selectedCategoryName]

    # Menu de Apps
    $appOptions = $appsInCategory
    $selectedAppIndices = Show-Menu -Options $appOptions -Title "APLICATIVOS EM '$selectedCategoryName'" -MultiSelect $true
    if ($null -eq $selectedAppIndices -or $selectedAppIndices.Count -eq 0) { return }

    Write-Host "`nIniciando a instalação. Sente-se e finja que está sendo produtivo." -ForegroundColor Cyan
    $successCount = 0; $failCount = 0
    foreach ($index in $selectedAppIndices) {
        $app = $appOptions[$index]
        Write-Host "`n[*] Instalando $($app.Name)..." -ForegroundColor Yellow
        try {
            $process = Start-Process "winget" -ArgumentList "install --id $($app.ID) -e --accept-package-agreements --accept-source-agreements --silent" -Wait -PassThru
            if ($process.ExitCode -eq 0) {
                Write-Host "  V $($app.Name) instalado. Mais um ícone para a sua coleção." -ForegroundColor Green
                $successCount++
            } else {
                Write-Host "  ! Instalação de $($app.Name) retornou um código estranho ($($process.ExitCode)), mas vamos fingir que deu certo." -ForegroundColor Yellow
                $successCount++
            }
        } catch {
            Write-Host "  X Erro ao instalar $($app.Name). Às vezes, a tecnologia decide não colaborar." -ForegroundColor Red
            $failCount++
        }
    }
    Write-Host "`nResumo da ópera:" -ForegroundColor Cyan
    Write-Host " - Sucesso: $successCount" -ForegroundColor Green
    Write-Host " - Falhas (ou apenas apps teimosos): $failCount" -ForegroundColor Red
    Read-Host "`nInstalação em massa concluída. Pressione Enter para continuar."
}