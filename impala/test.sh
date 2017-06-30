echo "BASH_SOURCE: $BASH_SOURCE"
echo "{BASH_SOURCE[0]}=${BASH_SOURCE[0]}"
echo "dirname = $(dirname ${BASH_SOURCE[0]})"
echo "$(dirname "$(cd $(dirname "${BASH_SOURCE[0]}") >/dev/null && pwd)")"
