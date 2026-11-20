# Quadro do Guia CMD — Prompt de Comando do Windows

Objetivo: um guia estático em pt-BR do Prompt de Comando (`cmd.exe`) do Windows, no mesmo molde do Guia PowerShell: uma aula por comando, saídas reais anonimizadas, missões no modo “cole a saída do terminal”, sem simulador por enquanto.

Esqueleto criado em 20/11/2026 (America/Sao_Paulo) por Tito, em paralelo com o `pssim.js` do PowerShell, por decisão da Nova depois da pergunta do Wallyson. Esqueleto: `671edbe`, quadro com esse hash: `4121b7f`. Lote 1 escrito no mesmo dia, a partir de `_saidas-anon/cmd-lote1.txt` (Mira, checador OK). Sem push.

## Regras (as mesmas do Guia PowerShell)

- **Anonimizar.** No texto e nas saídas só existem a usuária fictícia `ana`, o computador `NOTEBOOK` e o caminho `C:\Users\ana`. Nada da máquina real: nome do computador, usuário, IP, MAC, SID, serial, GUID, nome de rede.
- **Nunca inventar saída.** Se a coleta ainda não chegou, a caixa fica marcada como **a coletar**. Placeholder não é resposta do terminal.
- **Nunca traduzir mensagens de erro.** Elas entram exatamente como o `cmd` escreveu (pt-BR ou en-US). A explicação, em português, vem ao lado.
- **Aulas só a partir de `_saidas-anon/`.** A escrita usa a versão já anonimizada e revisada. O bruto fica em `_saidas/` e não entra no git.
- **`tools/checar-privacidade.sh` OK antes de todo commit.** O script tem padrões embutidos e, se existir, lê a lista real fora do repo (`../.proibido-cmd.txt`, ou `PROIBIDO=caminho`). A Mira mantém esse arquivo, com os valores reais, fora do repositório.
- **Nada vai para o GitHub sem o OK do Wallyson.** Só commit local, `git add` explícito (nunca `-a`), autor `wallyson` / `wallyson@localhost`. Sem push.

## Regras de coleta do CMD (definidas pela Mira)

Só leitura e demo, com `cmd /c`, numa pasta de teste com guarda e caminho absoluto. Sem admin por enquanto. Atenção extra para `ipconfig`, `systeminfo` e `whoami` (revisão da Mira, linha a linha, antes de anonimizar).

- Todo script começa com a guarda `cd /d C:\caminho\absoluto\teste || exit /b 1`.
- Nada de `del` nem `rd /s /q` com variável ou caminho relativo: variável vazia pode virar `rd /s /q \`.
- `del *.*` pede S/N e trava a coleta. Use `/q`, só dentro da pasta de teste.
- Acentos: o CMD sai em cp850. Rode `chcp 65001` antes ou converta na captura.
- Nada de `set` sem filtro (vaza variáveis de ambiente), a mesma regra do `Env:` do PowerShell. A aula de variáveis ensina `set NOME=` só com filtro ou nome.
- O que vaza e o checador precisa pegar (também em minúsculas):
  - o `dir` mostra o serial do volume (`Número de Série do Volume` no formato hex `XXXX-XXXX`; o placeholder anonimizado é `XXXX-XXXX`, com X literais, que não são hex);
  - o `C:\Users\<nome>` de qualquer usuário real (no guia só vale `C:\Users\ana`);
  - o nome do computador em `systeminfo` / `whoami` / `hostname` (no guia vira `NOTEBOOK`; o `whoami` no formato `nome-do-pc\usuario` também, inclusive em minúsculas);
  - o `ipconfig` mostra IPs, MAC (`Endereço Físico`) e sufixo DNS.
- **O `systeminfo` NÃO é coletado.** A aula usa uma saída de exemplo, marcada como exemplo.
- Sem inventar a saída na coleta: o que o `cmd` responder é o que se guarda em `_saidas/`, depois a Mira anonimiza em `_saidas-anon/`.

## Donos

| Papel | Quem |
|---|---|
| Esqueleto, `NIVEIS` (só o Tito edita este arquivo), quadro, site, checador, testes | Tito |
| Listas do lote 1 e script de coleta (`cmd /c`, pasta de teste com guarda) | Luna |
| Revisão linha a linha e anonimização; mantém o `.proibido-cmd.txt` fora do repo | Mira |
| Lote 2, aulas de **arquivo/texto** (pipe com find/findstr/sort/more, attrib, xcopy, robocopy, tree, where, ver) | Tito |
| Lote 2, aulas de **script** (`set`, `if`, `for`, `goto`/`call`, `%errorlevel%`, `&&`/`||`, `.bat`) | Zeca |

Lote 1: Luna (listas e script de coleta, 119 comandos em 9 aulas) e Mira (revisão linha a linha e anonimização em `_saidas-anon/cmd-lote1.txt`). O Tito não coleta: neste Linux não há `cmd.exe`. A escrita das aulas do lote 1 usou só o arquivo anonimizado. O bruto em `_saidas/` não entra no git.

## Agrupamento das aulas

O lote 1 segue as listas da Luna (`/workspace/cmd-coleta/listas-lote1.md`); o `NIVEIS` está alinhado a elas.

- **`md` e `rd` juntos** (`md-rd.html`): criar e apagar pasta são o par natural (um desfaz o outro). A aula cobre também os sinônimos `mkdir` e `rmdir`.
- **`copy`, `move`, `del` e `ren` juntos** (`copy-move-del.html`), como a Luna coletou. O critério inicial do Tito (aulas separadas, com o `del` sozinho por causa do risco e do `del *.*` sem `/q`) ficou para um possível desdobramento futuro. No Nível 2 ainda existe um `ren.html` `{pronta:false}`, mas o `ren` já aparece nesta aula do lote 1.
- **`date /t` e `time /t` em aulas separadas** (Nível 2): uma aula por comando, como a Nova pediu.
- **`find` e `findstr` em aulas separadas** (Nível 2): a sintaxe não é a mesma.

## Nível 1

Legenda do status: lista → coleta → escrita → revisão. O hash entra no commit em que a aula ficou pronta. Escrita do lote 1: Tito, só a partir de `_saidas-anon/cmd-lote1.txt`.

Notas da coleta (Luna) e da fidelidade (Mira): o lote 1 tem **119 comandos em 9 aulas**. `abrir-cmd` e `cls` ficam só no texto (sem saída coletada e sem missão rode-local). O `echo off` é explicado só em texto, sem saída. No `cmd` real há uma linha em branco entre a saída e o próximo prompt; essa linha entra nas sessões exibidas. O `echo texto > arquivo` grava o espaço que vier antes do `>`; o `type` mostra esse espaço no fim (dica nas aulas de `echo` e de redirecionamento). A primeira captura de `type notas.txt relatorio.txt` veio poluída pelo invólucro do PowerShell e não foi usada. A Mira recolheu e anonimizou de novo em `_saidas-anon/recoleta-type.txt` (checador OK): o `cmd` escreve uma linha em branco, o nome do arquivo e mais duas linhas em branco antes do conteúdo de cada arquivo. Essa saída entra na aula `type.html` Hash da recoleta na aula: `193aaa0`.

| Aula | Slug | Dono (lista/coleta · revisão) | Status | Hash |
|---|---|---|---|---|
| Início | `index.html` | Tito (esqueleto) | escrita (capa; sem saída a coletar) | `671edbe` |
| O que é o Prompt de Comando | `introducao.html` | Tito (página modelo) | escrita (esqueleto; um placeholder de missão) | `671edbe` |
| Abrindo o Prompt de Comando | `abrir-cmd.html` | Luna · Mira | escrita (só texto; sem missão) | `553e122` |
| Listando (`dir`) | `dir.html` | Luna · Mira | escrita | `553e122` |
| Mudando de Pasta (`cd`) | `cd.html` | Luna · Mira | escrita | `553e122` |
| Criando e Apagando Pastas (`md` e `rd`) | `md-rd.html` | Luna · Mira | escrita | `553e122` |
| Copiando, Movendo e Apagando (`copy`, `move`, `del` e `ren`) | `copy-move-del.html` | Luna · Mira | escrita | `553e122` |
| Lendo Arquivos (`type`) | `type.html` | Luna · Mira | escrita (recoleta com vários arquivos) | `193aaa0` |
| Escrevendo na Tela (`echo`) | `echo.html` | Luna · Mira | escrita | `553e122` |
| Limpando a Tela (`cls`) | `cls.html` | Luna · Mira | escrita (só texto; sem missão) | `553e122` |
| A Ajuda (`help` e `/?`) | `help.html` | Luna · Mira | escrita | `553e122` |
| Curingas (`*` e `?`) | `curingas.html` | Luna · Mira | escrita | `553e122` |
| Redirecionamento (`>` e `>>`) | `redirecionamento.html` | Luna · Mira | escrita | `553e122` |

O lote 1 é o Nível 1 inteiro (as aulas obrigatórias que a Nova fechou), todas `pronta` no `NIVEIS` (sem `{pronta:false}`). A coleta foi da Luna, no Windows, com as guardas acima; a Mira anonimizou e o checador passou. Bruto em `_saidas/cmd-lote1-bruto.txt` (gitignorado, não apagar nem mover).

## Nível 2

O `ren` já foi apresentado em `copy-move-del.html` no lote 1; o `ren.html` desta lista permanece `{pronta:false}` até uma aula só dele, se houver. Cronograma da Nova: aulas do lote 2 escritas até 22:30 de 20/11/2026 (America/Sao_Paulo). O PC do Wallyson estava offline: os esqueletos do Tito entram com placeholder visível « saída a coletar », sem inventar resposta do `cmd`. As páginas continuam `{pronta:false}` no `NIVEIS` até a coleta anonimizada da Mira. Metas `data-goal` das missões estão provisórias (`src` + `semerro`) e marcadas com `TODO`; `out`/`outre` só depois da saída real.

Donos do lote 2: **Tito** (arquivo/texto) e **Zeca** (script). O Tito é o único que edita o `NIVEIS` em `assets/site.js`.

### Aulas do Tito (arquivo/texto) — esqueleto, aguardando coleta

| Aula | Slug | Status | Hash |
|---|---|---|---|
| Procurando Texto (`find`) | `find.html` | esqueleto (saída a coletar) | (lote 2, a seguir) |
| Procurando com `findstr` | `findstr.html` | esqueleto (saída a coletar) | (lote 2, a seguir) |
| Página a Página (`more`) | `more.html` | esqueleto (saída a coletar) | (lote 2, a seguir) |
| Ordenando (`sort`) | `sort.html` | esqueleto (saída a coletar) | (lote 2, a seguir) |
| O Encadeamento (pipe) | `pipe.html` | esqueleto (saída a coletar) | (lote 2, a seguir) |
| Atributos (`attrib`) | `attrib.html` | esqueleto (saída a coletar) | (lote 2, a seguir) |
| Copiando Pastas (`xcopy`) | `xcopy.html` | esqueleto (saída a coletar) | (lote 2, a seguir) |
| Cópia Robusta (`robocopy`) | `robocopy.html` | esqueleto (saída a coletar; só na pasta de teste, sem `/MIR` nas missões) | (lote 2, a seguir) |
| Árvore de Pastas (`tree`) | `tree.html` | esqueleto (saída a coletar) | (lote 2, a seguir) |
| Onde Está o Comando (`where`) | `where.html` | esqueleto (saída a coletar; anonimizar caminho pessoal se aparecer) | (lote 2, a seguir) |
| A Versão do Windows (`ver`) | `ver.html` | esqueleto (saída a coletar) | (lote 2, a seguir) |

Ainda não há arquivo novo da Mira em `_saidas-anon/` para o lote 2. Quando chegar, o Tito substitui os placeholders só por essas saídas, finaliza as metas, roda o checador com `PROIBIDO` e o `testar-navegador`, e marca `pronta:true`.

### Aulas do Zeca (script) — ele escreve; o Tito não mexe nesses arquivos

`variaveis.html` (`set` / `%VAR%`, só com filtro ou nome), `if.html`, `for.html`, `goto.html` / `call.html`, `%errorlevel%`, `encadeamento.html` (`&&` / `||`), `arquivos-bat.html`. O Zeca não edita o `NIVEIS`; se criar páginas novas, o Tito inclui o slug.

Demais itens do Nível 2 ainda na proposta, fora deste lote: `tasklist`, `date /t`, `time /t`, `hostname`, e o `ren.html` separado.


## Nível 3 (proposta) — notas de privacidade e admin

| Aula | Slug | Nota |
|---|---|---|
| Arquivos `.bat` | `arquivos-bat.html` |  |
| `if` | `if.html` |  |
| `for` | `for.html` |  |
| `goto` e rótulos | `goto.html` |  |
| `call` | `call.html` |  |
| `setlocal` | `setlocal.html` |  |
| Parâmetros `%1` | `parametros.html` |  |
| `choice` | `choice.html` |  |
| `timeout` | `timeout.html` |  |
| `taskkill` | `taskkill.html` | cuidado: encerra processos; só demo com processo de teste, sem admin por enquanto |
| `sc query` | `sc-query.html` | leitura; atenção ao nome da máquina se aparecer |
| `ipconfig` | `ipconfig.html` | **privacidade:** IPs, MAC (`Endereço Físico`), sufixo DNS; revisão da Mira |
| `ping` | `ping.html` | destino de exemplo (não vazar host interno real) |
| `systeminfo` | `systeminfo.html` | **privacidade:** **não coletar**; a aula usa saída de exemplo, marcada como exemplo |
| `whoami` | `whoami.html` | **privacidade:** nome do computador e do usuário (também em minúsculas); revisão da Mira |
| `shutdown` | `shutdown.html` | cuidado / admin: não executar de verdade na coleta; ilustrativo |

## Entrega das 21:00 (20/11/2026, America/Sao_Paulo)

- [x] Esqueleto em `/workspace/planos-trabalho/guia-cmd` (git local, sem push) — `671edbe`; quadro com o hash — `4121b7f`
- [x] `NIVEIS` em 3 níveis, slugs em kebab-case alinhados às listas da Luna; lote 1 (index, introdução e as 11 páginas do Nível 1) sem `{pronta:false}`; Níveis 2 e 3 continuam `{pronta:false}`
- [x] Lote 1 coletado (bruto gitignorado) e anonimizado pela Mira em `_saidas-anon/cmd-lote1.txt`
- [x] Lote 1 escrito (9 aulas com saída real + `abrir-cmd` e `cls` só em texto), missões rode-local, checador de privacidade OK, `testar-missoes.js` e `testar-navegador.js --todas` OK (18 “Missão cumprida!” com a saída real, 76 negativos sem falso positivo; `introducao` “Quase lá!” com `(sem saída)`). Hash do lote: `553e122`.
- [x] Telas de duas aulas: `/workspace/telas/cmd-dir.png` e `/workspace/telas/cmd-echo.png` (fora do repo)
