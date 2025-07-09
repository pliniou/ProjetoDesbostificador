# Desbostificador v1.0

### Uma Solução da Cebola Studios & Softwares

*"Otimizando sistemas com mais camadas que o esperado."*

![Versao PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue.svg)
![Compatibilidade](https://img.shields.io/badge/Windows-11-0078d6.svg)
![Licenca](https://img.shields.io/badge/Licenca-MIT-green.svg)
![Status](https://img.shields.io/badge/Status-Pronto%20para%20Produ%C3%A7%C3%A3o-brightgreen.svg)

Um script de PowerShell completo e modular para otimizar, limpar ("debloat") e personalizar instalações do Windows 11, focado em melhorar o desempenho, a privacidade e a experiência do usuário. O objetivo é fornecer uma interface de menu simples e centralizada para executar tarefas complexas de pós-instalação.

<div align="center">

![Gif de Demonstração do Script](https://i.imgur.com/ED8A4922-FA25-43B3-96A9-596B86D17A2B.png)

*A interface de usuário da Cebola Studios: funcionalidade e elegância.*

</div>

> [!WARNING]
> **AVISO IMPORTANTE E INDISPENSÁVEL**
>
> Este script realiza modificações profundas no sistema operacional. O uso incorreto pode causar instabilidade, choros e arrependimentos.
>
> **É extremamente recomendado que você utilize a funcionalidade "[1] Backup e Restauração" para criar um Ponto de Restauração do Sistema antes de aplicar quaisquer outras modificações.**
>
> A Cebola Studios e seus afiliados não se responsabilizam por quaisquer danos, telas azuis ou crises existenciais causadas pelo uso desta ferramenta. **Use por sua conta e risco.**

---

## ✨ Funcionalidades Principais

O Desbostificador é dividido em módulos para facilitar sua jornada de otimização:

### 🛡️ Segurança e Backup
- **Pontos de Restauração**: Ferramenta integrada para criar backups do registro e pontos de restauração do sistema
- **Rollback Inteligente**: Possibilidade de reverter modificações caso algo saia do controle
- **Verificação de Integridade**: Validação do sistema antes e após as modificações

### ⚡ Otimização de Desempenho
- **Planos de Energia**: Ajusta configurações para máximo desempenho
- **Serviços Desnecessários**: Desativa serviços que consomem recursos sem necessidade
- **Limpeza Profunda**: Remove arquivos temporários, cache e logs antigos
- **Registro Limpo**: Otimiza o registro do Windows para melhor responsividade

### 🗑️ Removedor de Bloatware
- **Apps Pré-instalados**: Elimina aplicativos da Microsoft Store que você nunca pediu
- **Serviços Redundantes**: Remove funcionalidades desnecessárias do sistema
- **Limpeza Seletiva**: Permite escolher exatamente o que remover

### 🔒 Privacidade Reforçada
- **Telemetria Zero**: Desativa completamente o envio de dados para a Microsoft
- **Cortana Silenciada**: Remove ou desativa a assistente virtual
- **Rastreamento Bloqueado**: Impede coleta de dados de uso e comportamento
- **DNS Seguro**: Configura servidores DNS focados em privacidade

### 📦 Instalador de Apps
- **Winget Integrado**: Instala aplicativos populares automaticamente
- **Pacotes Curados**: Lista de software essencial para produtividade
- **Instalação Silenciosa**: Sem cliques desnecessários ou interrupções
- **Atualizações Automáticas**: Configura atualizações automáticas para apps instalados

### 🎨 Personalização Profunda
- **Modo Escuro**: Ativa tema escuro em todo o sistema
- **Menu Clássico**: Restaura o menu de contexto tradicional
- **Interface Limpa**: Remove elementos visuais desnecessários
- **Configurações Avançadas**: Ajustes finos de aparência e comportamento

### 💻 Interface Interativa
- **Navegação Intuitiva**: Menus de fácil navegação com setas do teclado
- **Seleção Múltipla**: Marque várias opções de uma vez
- **Descrições Detalhadas**: Explicações (sarcásticas) para cada funcionalidade
- **Progresso Visual**: Barra de progresso e feedback em tempo real

---

## 🚀 Instalação e Uso

### Pré-requisitos

| Requisito | Versão/Especificação |
|-----------|---------------------|
| **Sistema Operacional** | Windows 11 (todas as versões) |
| **PowerShell** | Versão 5.1 ou superior |
| **Privilégios** | Administrador (obrigatório) |
| **Conexão Internet** | Necessária para instalação de apps |
| **Espaço Livre** | Mínimo 1GB para operações temporárias |

### 📥 Download

Baixe a versão mais recente diretamente do GitHub:

```bash
git clone https://github.com/pliniou/desbostificador.git
```

Ou faça o download manual do [arquivo ZIP](https://github.com/pliniou/desbostificador/archive/main.zip).

### 💻 Execução

1. **Extraia** o arquivo para uma pasta de sua escolha
2. **Abra o PowerShell como Administrador**:
   - Pressione `Win + X`
   - Selecione "Terminal (Admin)" ou "PowerShell (Admin)"
3. **Navegue** até a pasta do projeto:
   ```powershell
   cd "C:\caminho\para\a\pasta\Desbostificador"
   ```
4. **Execute** o script principal:
   ```powershell
   .\MenuPrincipal.ps1
   ```
5. **Navegue** pelos menus usando:
   - `↑↓` para navegar
   - `Espaço` para marcar/desmarcar opções
   - `Enter` para executar
   - `Esc` para voltar ao menu anterior

### 🔧 Uso Avançado

Para usuários experientes, você pode executar módulos específicos diretamente:

```powershell
# Apenas backup e restauração
.\Modules\01-BackupRestauracao.ps1

# Só otimização de sistema
.\Modules\02-OtimizacaoSistema.ps1

# Executar em modo silencioso (sem interação)
.\MenuPrincipal.ps1 -SilentMode -ConfigFile "config.json"
```

---

## 📁 Estrutura do Projeto

```
Desbostificador/
├── 📁 Modules/
│   ├── 📜 01-BackupRestauracao.ps1     # Backup e pontos de restauração
│   ├── 📜 02-OtimizacaoSistema.ps1     # Otimizações de performance
│   ├── 📜 03-Bloatware.ps1             # Remoção de bloatware
│   ├── 📜 04-Aplicativos.ps1           # Instalação de apps úteis
│   ├── 📜 05-Personalizacao.ps1        # Customização da interface
│   └── 📜 06-ServicosTelemetria.ps1    # Privacidade e telemetria
├── 📁 Config/
│   ├── 📜 apps-essenciais.json         # Lista de apps para instalação
│   ├── 📜 bloatware-list.json          # Apps para remoção
│   └── 📜 servicos-desnecessarios.json # Serviços para desativar
├── 📁 Logs/
│   └── 📜 desbostificador.log          # Log de operações
├── 📜 MenuPrincipal.ps1                # Script principal
├── 📜 README.md                        # Esta documentação
└── 📜 LICENSE                          # Licença MIT
```

---

## 🛠️ Configuração Avançada

### Arquivo de Configuração

Crie um arquivo `config.json` para personalizar o comportamento:

```json
{
  "backup": {
    "criar_ponto_restauracao": true,
    "backup_registro": true,
    "pasta_backup": "C:\\Backup\\Desbostificador"
  },
  "otimizacao": {
    "plano_energia": "high_performance",
    "desativar_hibernacao": true,
    "limpar_temp": true
  },
  "privacidade": {
    "desativar_telemetria": true,
    "remover_cortana": true,
    "bloquear_rastreamento": true
  }
}
```

### Personalização de Listas

Edite os arquivos JSON na pasta `Config/` para personalizar:
- Quais apps instalar automaticamente
- Quais bloatwares remover
- Quais serviços desativar

---

## 🔧 Solução de Problemas

### Problemas Comuns

| Problema | Solução |
|----------|---------|
| **Script não executa** | Verifique se está rodando como Administrador |
| **Erro de execução** | Execute `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser` |
| **Apps não instalam** | Verifique conexão com internet e disponibilidade do Winget |
| **Sistema instável** | Use o ponto de restauração criado pelo módulo de backup |

### Logs e Depuração

Todos os logs são salvos em `Logs/desbostificador.log`. Para depuração avançada:

```powershell
# Executar com log detalhado
.\MenuPrincipal.ps1 -Verbose -Debug
```

---

## 🤝 Contribuindo

Contribuições são bem-vindas! Para contribuir:

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/NovaFuncionalidade`)
3. Commit suas mudanças (`git commit -m 'Adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/NovaFuncionalidade`)
5. Abra um Pull Request

### Diretrizes de Contribuição

- Mantenha o código limpo e comentado
- Teste todas as funcionalidades antes do PR
- Mantenha o tom irônico mas profissional na documentação
- Adicione logs apropriados para novas funcionalidades

---

## 📝 Changelog

### v1.0.0 (Atual)
- ✨ Lançamento inicial
- 🛡️ Sistema de backup e restauração
- ⚡ Otimizações de performance
- 🗑️ Remoção de bloatware
- 🔒 Melhorias de privacidade
- 📦 Instalador de apps integrado
- 🎨 Personalização de interface

---

## 📜 Licença

Distribuído sob a Licença MIT. Veja o arquivo `LICENSE` para mais informações.

Basicamente, você pode fazer o que quiser com este código, mas a responsabilidade é toda sua. A Cebola Studios não se responsabiliza por eventuais danos causados pelo uso desta ferramenta.

---

## 🏆 Créditos

Desenvolvido com ❤️ (e muito café) pela **Cebola Studios & Softwares**.

*"Porque toda cebola tem suas camadas, e todo sistema Windows também."*

---

<div align="center">

**[⬆ Voltar ao Topo](#desbostificador-v10)**

</div>
```