#!/bin/bash
# paste-to-slack: lê stdin e publica num canal ou DM de Slack.
# Texto curto vai como mensagem; acima de MAX_INLINE chars vai como snippet (ficheiro).
#
# Uso: ... | paste-to-slack [-c destino] [-u nome] [-w]
#   -c  destino: '#canal' ou '@utilizador'. Canais em slack_channels (Ansible) resolvem
#       localmente; os restantes são procurados na API (conversations.list).
#       Canais privados: a app tem de ser convidada (/invite @paste-to-slack).
#       Por omissão: {{ slack_default_channel }}
#   -u  nome apresentado como autor (hostname por omissão)
#   -w  não envolver o texto em ```
#
# Slack bot token (xoxb-…).
# Scopes: chat:write chat:write.customize files:write users:read channels:read groups:read

#Slack user token (JF)
TOKEN="$(cat ~/.slack.app)"
TARGET="@adagios"
USERNAME="gsmf"
WRAP=true
MAX_INLINE=3500   # Slack recomenda <= 4000 chars por mensagem

# canais conhecidos -> IDs (gerado a partir de slack_channels)
declare -a CHANNELS=(
)

PROXY=()
CURL=(curl -sS --max-time 30 --retry 3 "${PROXY[@]}")
API=https://slack.com/api

while getopts "c:u:w" opt; do
    case "$opt" in
        c) TARGET="$OPTARG" ;;
        u) USERNAME="$OPTARG" ;;
        w) WRAP=false ;;
        *) echo "uso: $0 [-c destino] [-u nome] [-w] < texto" >&2; exit 2 ;;
    esac
done

err() { echo "paste-to-slack: $*" >&2; }

# api <método> [opções curl…]: chama a Web API e devolve o JSON; falha se ok != true.
# --retry repete em 429/5xx/timeouts e respeita o Retry-After do Slack (curl >= 7.67).
api() {
    local method=$1 result; shift
    # err "${CURL[@]}" "-H Authorization: Bearer $TOKEN" "$@" "$API/$method"
    result=$("${CURL[@]}" -H "Authorization: Bearer $TOKEN" "$@" "$API/$method") || return 1
    if [[ $(jq -r .ok <<<"$result" 2>/dev/null) != true ]]; then
        err "$method: $(jq -r '.error // "resposta inválida"' <<<"$result" 2>/dev/null)"
        return 1
    fi
    echo "$result"
}

# channel_id <#canal>: mapa local primeiro; senão procura na API (público ou privado onde a app está)
channel_id() {
    local name=${1#\#} cursor='' page id
    if [[ -n ${CHANNELS[$name]} ]]; then
        echo "${CHANNELS[$name]}"
        return
    fi
    while :; do
        page=$(api conversations.list -d types=public_channel,private_channel \
               -d exclude_archived=true -d limit=200 --data-urlencode "cursor=$cursor") || return 1
        id=$(jq -r --arg n "$name" '.channels[] | select(.name == $n) | .id' <<<"$page")
        [[ -n $id ]] && { echo "$id"; return; }
        cursor=$(jq -r '.response_metadata.next_cursor // empty' <<<"$page")
        [[ -n $cursor ]] || break
    done
    err "canal '$1' não encontrado (privado? convida a app com /invite). Para evitar a procura na API adiciona-o a slack_channels"
    return 1
}

# user_id <@handle>: procura por handle ou display name (users.list, paginado)
user_id() {
    local name=${1#@} cursor='' page id
    while :; do
        page=$(api users.list -d limit=200 --data-urlencode "cursor=$cursor") || return 1
        id=$(jq -r --arg n "$name" '.members[]
                | select(.deleted | not)
                | select(.name == $n or .profile.display_name == $n)
                | .id' <<<"$page" | head -1)
        [[ -n $id ]] && { echo "$id"; return; }
        cursor=$(jq -r '.response_metadata.next_cursor // empty' <<<"$page")
        [[ -n $cursor ]] || break
    done
    err "utilizador '$1' não encontrado"
    return 1
}

# target_id <#canal|@utilizador>: resolve o destino para um ID de Slack
target_id() {
    case "$1" in
        @*) user_id "$1" ;;
        *)  channel_id "$1" ;;
    esac
}

# post_message <id> <texto>
post_message() {
    local payload
    payload=$(jq -n --arg channel "$1" --arg username "$USERNAME" --arg text "$2" \
        '{channel: $channel, username: $username, text: $text}')
    api chat.postMessage -H 'Content-type: application/json; charset=utf-8' \
        --data-binary "$payload" >/dev/null
}

# upload_snippet <id> <texto>: files.getUploadURLExternal -> POST bytes -> files.completeUploadExternal
upload_snippet() {
    local filename="$USERNAME-$(date +%F_%H%M%S).txt" meta url id payload
    meta=$(api files.getUploadURLExternal -d snippet_type=text \
           --data-urlencode "filename=$filename" \
           -d "length=$(printf '%s' "$2" | wc -c| sed "s/ *//")") || return 1
    url=$(jq -r .upload_url <<<"$meta")
    id=$(jq -r .file_id <<<"$meta")
    printf '%s' "$2" | "${CURL[@]}" --fail -o /dev/null \
        -H 'Content-Type: application/octet-stream' --data-binary @- "$url" || return 1
    payload=$(jq -n --arg id "$id" --arg title "$filename" --arg channels "$1" --arg username "$USERNAME" \
        '{files: [{id: $id, title: $title}], channels: $channels, username: $username}')
    api files.completeUploadExternal -H 'Content-type: application/json; charset=utf-8' \
        --data-binary "$payload" >/dev/null
}

body=$(cat)
tid=$(target_id "$TARGET") || exit 1

if (( ${#body} > MAX_INLINE )); then
    upload_snippet "$tid" "$body" && exit 0
    FILE="/tmp/paste-to-slack-$(date +%F_%H%M%S).txt"
    printf '%s\n' "$body" > "$FILE"
    post_message "$tid" "<!channel> Failed to upload errors as snippet :rat: :rat: :rat:"$'\n'"Kept the msg at \`$FILE\`"
    exit 1
fi

$WRAP && body=$'```\n'"$body"$'\n```'
post_message "$tid" "$body"

# vim: filetype=sh sw=4 ts=4 et
