# =========================================================
# Lazy 1Password Secrets Loader
# =========================================================
# Defers 1Password authentication until secrets are actually needed
# This keeps terminal startup blazingly fast
# 
# Usage:
#   load-secrets         - Load all secrets (required for PAT tokens)
#   load-secrets-quiet   - Load secrets without output
#   $ARTIFACTORY_AUTH_TOKEN, $JIRA_PAT, etc. - Available after loading

_OP_SECRETS_LOADED=0

_load_op_secrets() {
  if (( _OP_SECRETS_LOADED )); then
    return 0
  fi

  _OP_SECRETS_LOADED=1

  export ARTIFACTORY_AUTH_TOKEN=$(op read 'op://Employee/JFrog PAT/credential')
  export JIRA_PAT=$(op read 'op://Employee/Jira PAT/credential')
  export CONTENTFUL_CMA_TOKEN=$(op read 'op://Employee/Contentful PAT/credential')
  export GH_PAT=$(op read 'op://Employee/GitHub PAT/credential')

  export JIRA_API_TOKEN=${JIRA_PAT}
}

# Public command to load secrets
load-secrets() {
  echo "🔐 Loading 1Password secrets..."
  _load_op_secrets && echo "✅ Secrets loaded" || echo "❌ Failed to load secrets"
}

# Silent version for scripts
load-secrets-quiet() {
  _load_op_secrets
}

# Optional: Create wrapper functions for commands that need secrets
# Uncomment if you want automatic loading for specific tools
# Example:
# jira() { load-secrets-quiet; command jira "$@"; }
# gh() { load-secrets-quiet; command gh "$@"; }
