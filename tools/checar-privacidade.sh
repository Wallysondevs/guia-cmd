#!/usr/bin/env bash
# Varre páginas e histórico do git atrás das strings proibidas.
# Lista real (valores da máquina) fica FORA do repo:
#   ../.proibido-cmd.txt   (ou PROIBIDO=caminho)
# Se o arquivo existir, as linhas dele entram na conferência, além
# dos padrões embutidos (genéricos: SID, MAC, GUID, IP, serial do
# volume do dir, C:\Users\<nome> que não seja ana, Endereço Físico).
# Os nomes reais (computador, usuário, pastas da máquina) NÃO ficam
# neste script: a Mira os mantém só no arquivo de fora do repo.
# "re:" = expressão regular (grep -P), sem diferenciar maiúsculas.
set -u
cd "$(dirname "$0")/.."
LISTA="${PROIBIDO:-../.proibido-cmd.txt}"

padroes=()
# --- padrões embutidos genéricos (sempre; sem valores da máquina) ---
padroes+=("re:S-1-5-21-\\d+-\\d+-\\d+(-\\d+)?")
padroes+=("re:\\b(?!02[:-])([0-9a-f]{2}[:-]){5}[0-9a-f]{2}\\b")
padroes+=("re:\\b[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\\b")
padroes+=("re:(?<![\\d.])(?!192\\.168\\.0\\.|127\\.|255\\.)(?:25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]\\d)\\.(\\d{1,3}\\.){2}\\d{1,3}(?![\\d.])")
# Número de Série do Volume do dir (quatro hex, hífen, quatro hex).
# O placeholder anonimizado usa XXXX-XXXX (X não é hex, então não casa).
padroes+=("re:(Número de Série do Volume|Volume Serial Number).{0,8}[0-9A-F]{4}-[0-9A-F]{4}")
# C:\Users\<nome> que não seja ana / Public / Default
padroes+=("re:C:\\\\Users\\\\(?!ana\\b|Public\\b|Default\\b)[^\\\\s\\\\/<>\"]+")
# Endereço Físico do ipconfig /all (o padrão de MAC acima também pega)
padroes+=("re:(Endereço Físico|Physical Address).{0,40}([0-9A-F]{2}[:-]){5}[0-9A-F]{2}")

if [ -f "$LISTA" ]; then
  echo "Usando lista $LISTA (além dos padrões embutidos)."
  while IFS= read -r linha || [ -n "$linha" ]; do
    [[ -z "$linha" || "$linha" == \#* ]] && continue
    padroes+=("$linha")
  done < "$LISTA"
else
  echo "Lista $LISTA não encontrada; usando só os padrões embutidos."
fi

falhou=0
for pad0 in "${padroes[@]}"; do
  if [[ "$pad0" == re:* ]]; then pad="${pad0#re:}"; opt=(-P -i); else pad="$pad0"; opt=(-F -i); fi
  achou=$(grep -rn "${opt[@]}" --include='*.html' --include='*.js' --include='*.md' --include='*.css' --include='*.txt' --exclude-dir=.git --exclude-dir=_saidas -e "$pad" . | head -5)
  hist=$(git log --all -p 2>/dev/null | grep -c "${opt[@]}" -e "$pad")
  if [ -n "$achou" ] || [ "$hist" != "0" ]; then
    falhou=1; echo "FALHA: $pad (histórico: $hist)"; [ -n "$achou" ] && echo "$achou"
  fi
done
[ $falhou = 0 ] && echo "OK: nenhuma string proibida nas páginas nem no histórico."
exit $falhou
