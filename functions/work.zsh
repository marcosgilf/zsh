# =========================================================
# Work
# =========================================================

flush-translations(){
  local api=${1:-profile}
  echo "[DEV] Flushing translations service cache..."
  curl -X 'DELETE' \
  'https://dev.services.ifb.ingka.com/translations/cache' \
  -H 'accept: */*'
  echo "[DEV] Flushing $api ingka translations cache..."
  curl -X 'DELETE' \
  https://dev.ecom.ifb.ingka.com/${api}/api/v1/translations \
  -H 'accept: application/json'
  echo "[DEV] Flushing $api translations cache..."
  curl -X 'DELETE' \
  https://ifb.ikeadt.com/${api}/api/v1/translations \
  -H 'accept: application/json'
}

flush-translations-prod(){
  local api=${1:-profile}
  echo "[PROD] Flushing translations service cache..."
  curl -X 'DELETE' \
  'https://services.ifb.ingka.com/translations/cache' \
  -H 'accept: */*'
  echo "[PROD] Flushing $api ingka translations cache..."
  curl -X 'DELETE' \
  https://ecom.ifb.ingka.com/${api}/api/v1/translations \
  -H 'accept: application/json'
  echo "[PROD] Flushing $api ikea translations cache..."
  curl -X 'DELETE' \
  https://ifb.ikea.com/${api}/api/v1/translations \
  -H 'accept: application/json'
}