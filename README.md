\# Desbostificador v1.0

\### Uma Solução da Cebola Studios \& Softwares

\*"Otimizando sistemas com mais camadas que o esperado."\*


\[cite\_start]!\[Versao PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue.svg) \[cite: 15] \[cite\_start]!\[Compatibilidade](https://img.shields.io/badge/Windows-11-0078d6.svg) \[cite: 15] \[cite\_start]!\[Licenca](https://img.shields.io/badge/Licenca-MIT-green.svg) \[cite: 4]


\[cite\_start]Um script de PowerShell completo e modular para otimizar, limpar ("debloat") e personalizar instalações do Windows 11, focado em melhorar o desempenho, a privacidade e a experiência do usuário. \[cite: 4] \[cite\_start]O objetivo é fornecer uma interface de menu simples e centralizada para executar tarefas complexas de pós-instalação. \[cite: 8]


<div align="center">

!\[Gif de Demonstração do Script](https://i.imgur.com/ED8A4922-FA25-43B3-96A9-596B86D17A2B.png)

\*A interface de usuário da Cebola Studios: funcionalidade e elegância.\*

</div>


> \[!WARNING]

> \*\*AVISO IMPORTANTE E INDISPENSÁVEL\*\*

> \[cite\_start]Este script realiza modificações profundas no sistema operacional. \[cite: 5] \[cite\_start]O uso incorreto pode causar instabilidade, choros e arrependimentos. \[cite: 6]

> \[cite\_start]\*\*É extremamente recomendado que você utilize a funcionalidade "\[1] Backup e Restauração" para criar um Ponto de Restauração do Sistema antes de aplicar quaisquer outras modificações.\*\* \[cite: 6]

> A Cebola Studios e seus afiliados não se responsabilizam por quaisquer danos, telas azuis ou crises existenciais causadas pelo uso desta ferramenta. \[cite\_start]\*\*Use por sua conta e risco.\*\* \[cite: 7]


---

\## ✨ Funcionalidades Principais

O Desbostificador é dividido em módulos para facilitar sua jornada de otimização:

\* \[cite\_start]\*\*Segurança em Primeiro Lugar:\*\* Ferramenta integrada para criar pontos de restauração e backups do registro. \[cite: 10] Essencial para os corajosos (ou descuidados).

\* \[cite\_start]\*\*Otimização de Desempenho:\*\* Ajusta o plano de energia, desativa serviços desnecessários e limpa arquivos temporários. \[cite: 11] Promete velocidade, mas efeitos placebo não estão descartados.

\* \[cite\_start]\*\*Removedor de Bloatware:\*\* Elimina aplicativos pré-instalados que a Microsoft jurava que você ia amar. \[cite: 14]

\* \[cite\_start]\*\*Privacidade Reforçada:\*\* Desativa serviços de telemetria, Cortana e outros mecanismos de rastreamento. \[cite: 13] Coloque seu chapéu de papel alumínio.

\* \[cite\_start]\*\*Instalador de Apps:\*\* Usa o `winget` para instalar silenciosamente aplicativos populares e úteis, poupando seu precioso tempo de cliques. \[cite: 12]

\* \[cite\_start]\*\*Personalização Profunda:\*\* Altera configurações da interface, como o modo escuro e o menu de contexto clássico, para que o Windows pareça menos... padrão. \[cite: 14]

\* \[cite\_start]\*\*Interface Interativa Aprimorada:\*\* Menus de fácil navegação com seleção múltipla e descrições (sarcásticas) para cada opção. \[cite: 9]


\## 🚀 Começando

Para colocar essa maravilha da engenharia para funcionar, siga os pré-requisitos e as instruções abaixo.

\### Pré-requisitos

\* \[cite\_start]\*\*Sistema Operacional:\*\* Windows 11. \[cite: 15]

\* \[cite\_start]\*\*PowerShell:\*\* Versão 5.1 ou superior. \[cite: 15]

\* \[cite\_start]\*\*Privilégios:\*\* É necessário executar o script como \*\*Administrador\*\*. \[cite: 16] Nosso script é educado e irá te avisar se você esquecer.

\* \[cite\_start]\*\*Conexão com a Internet:\*\* Necessária para o módulo de instalação de aplicativos (Winget). \[cite: 17]


\### 💻 Como Usar

1\.  Faça o download ou clone o repositório para uma pasta no seu computador.

2\.  Clique no \*\*Menu Iniciar\*\*, digite "PowerShell", clique com o botão direito e selecione \*\*"Executar como administrador"\*\*.

3\.  Na janela do PowerShell, navegue até a pasta onde você salvou o projeto.

&nbsp;   ```powershell

&nbsp;   cd "C:\\caminho\\para\\a\\pasta\\Desbostificador"

&nbsp;   ```

4\.  Execute o script principal:

&nbsp;   ```powershell

&nbsp;   .\\MenuPrincipal.ps1

&nbsp;   ```

5\.  \[cite\_start]Use as setas para navegar, `Espaço` para marcar múltiplas opções e `Enter` para executar as ações. \[cite: 20]


\## 📁 Estrutura do Projeto

\[cite\_start]Para os curiosos que gostam de olhar sob o capô, aqui está a organização dos arquivos: \[cite: 1]

└── 📁 Desbostificador
├── 📁 Modules
│   ├── 📜 01-BackupRestauracao.ps1
│   ├── 📜 02-OtimizacaoSistema.ps1
│   ├── 📜 03-Bloatware.ps1
│   ├── 📜 04-Aplicativos.ps1
│   ├── 📜 05-Personalizacao.ps1
│   └── 📜 06-ServicosTelemetria.ps1
├── 📜 MenuPrincipal.ps1
└── 📝 README.md


## 📜 Licença

Distribuído sob a Licença MIT. Veja o arquivo `LICENSE` para mais informações. Basicamente, você pode fazer o que quiser, mas a responsabilidade é toda sua.