# Houston for Powerlevel10k — ported from withastro/houston-vscode.
#
# This is colour only. It is sourced from the end of zsh/p10k.zsh, after every
# POWERLEVEL9K_* option has been set, so the lean prompt keeps all its
# behaviour — one line, transparent background, instant prompt, gitstatus —
# and only the palette changes. `p10k configure` can regenerate p10k.zsh
# without losing the theme; just re-add the source line at the bottom.
#
# Segment colours follow the same semantics as nvim/colors/houston.lua:
# directories blue, git-added mint, git-modified sand, errors pink, muted
# chrome in the comment grey.

() {
  emulate -L zsh -o extended_glob

  local gray='#858b98'     # lineNumber.activeForeground
  local comment='#545864'  # comment, lineNumber, ansiBrightBlack
  local blue='#54b9ff'     # keyword, storage, tag, info
  local mint='#4bf3c8'     # variable, attribute, git added
  local sand='#ffd493'     # string, number, git modified
  local peri='#acafff'     # type, class
  local cyan='#00daef'     # function, focusBorder
  local magenta='#cc75f4'  # ansiBrightMagenta
  local pink='#f4587e'     # editorError.foreground
  local yellow='#fbc23b'   # editorWarning.foreground
  local orange='#ff8551'   # notificationsWarningIcon

  # ── Prompt chrome and directory ───────────────────────────────────────
  typeset -g POWERLEVEL9K_RULER_FOREGROUND=$comment
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_FOREGROUND=$comment
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=$mint
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=$pink
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=$blue
  typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=$comment
  typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=$cyan

  # ── Git ───────────────────────────────────────────────────────────────
  typeset -g POWERLEVEL9K_VCS_VISUAL_IDENTIFIER_COLOR=$mint
  typeset -g POWERLEVEL9K_VCS_LOADING_VISUAL_IDENTIFIER_COLOR=$comment
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=$mint
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=$cyan
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=$sand

  # ── Command status and timing ─────────────────────────────────────────
  typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND=$mint
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND=$mint
  typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=$pink
  typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_FOREGROUND=$pink
  typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_FOREGROUND=$pink
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=$gray
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=$mint

  # ── Shell context ─────────────────────────────────────────────────────
  typeset -g POWERLEVEL9K_DIRENV_FOREGROUND=$sand
  typeset -g POWERLEVEL9K_VIM_SHELL_FOREGROUND=$mint
  typeset -g POWERLEVEL9K_NIX_SHELL_FOREGROUND=$blue
  typeset -g POWERLEVEL9K_CHEZMOI_SHELL_FOREGROUND=$blue
  typeset -g POWERLEVEL9K_PER_DIRECTORY_HISTORY_LOCAL_FOREGROUND=$peri
  typeset -g POWERLEVEL9K_PER_DIRECTORY_HISTORY_GLOBAL_FOREGROUND=$orange
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=$sand
  typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_FOREGROUND=$sand
  typeset -g POWERLEVEL9K_CONTEXT_FOREGROUND=$sand
  typeset -g POWERLEVEL9K_TOOLBOX_FOREGROUND=$sand
  typeset -g POWERLEVEL9K_PROXY_FOREGROUND=$gray

  # ── Language versions and version managers ────────────────────────────
  typeset -g POWERLEVEL9K_ASDF_FOREGROUND=$gray
  typeset -g POWERLEVEL9K_ASDF_RUBY_FOREGROUND=$pink
  typeset -g POWERLEVEL9K_ASDF_PYTHON_FOREGROUND=$cyan
  typeset -g POWERLEVEL9K_ASDF_GOLANG_FOREGROUND=$cyan
  typeset -g POWERLEVEL9K_ASDF_NODEJS_FOREGROUND=$mint
  typeset -g POWERLEVEL9K_ASDF_RUST_FOREGROUND=$cyan
  typeset -g POWERLEVEL9K_ASDF_DOTNET_CORE_FOREGROUND=$peri
  typeset -g POWERLEVEL9K_ASDF_FLUTTER_FOREGROUND=$cyan
  typeset -g POWERLEVEL9K_ASDF_LUA_FOREGROUND=$blue
  typeset -g POWERLEVEL9K_ASDF_JAVA_FOREGROUND=$blue
  typeset -g POWERLEVEL9K_ASDF_PERL_FOREGROUND=$gray
  typeset -g POWERLEVEL9K_ASDF_ERLANG_FOREGROUND=$magenta
  typeset -g POWERLEVEL9K_ASDF_ELIXIR_FOREGROUND=$magenta
  typeset -g POWERLEVEL9K_ASDF_POSTGRES_FOREGROUND=$blue
  typeset -g POWERLEVEL9K_ASDF_PHP_FOREGROUND=$peri
  typeset -g POWERLEVEL9K_ASDF_HASKELL_FOREGROUND=$orange
  typeset -g POWERLEVEL9K_ASDF_JULIA_FOREGROUND=$mint
  typeset -g POWERLEVEL9K_VIRTUALENV_FOREGROUND=$cyan
  typeset -g POWERLEVEL9K_ANACONDA_FOREGROUND=$cyan
  typeset -g POWERLEVEL9K_PYENV_FOREGROUND=$cyan
  typeset -g POWERLEVEL9K_GOENV_FOREGROUND=$cyan
  typeset -g POWERLEVEL9K_NODENV_FOREGROUND=$mint
  typeset -g POWERLEVEL9K_NVM_FOREGROUND=$mint
  typeset -g POWERLEVEL9K_NODEENV_FOREGROUND=$mint
  typeset -g POWERLEVEL9K_NODE_VERSION_FOREGROUND=$mint
  typeset -g POWERLEVEL9K_GO_VERSION_FOREGROUND=$cyan
  typeset -g POWERLEVEL9K_RUST_VERSION_FOREGROUND=$cyan
  typeset -g POWERLEVEL9K_DOTNET_VERSION_FOREGROUND=$peri
  typeset -g POWERLEVEL9K_PHP_VERSION_FOREGROUND=$peri
  typeset -g POWERLEVEL9K_LARAVEL_VERSION_FOREGROUND=$pink
  typeset -g POWERLEVEL9K_JAVA_VERSION_FOREGROUND=$blue
  typeset -g POWERLEVEL9K_PACKAGE_FOREGROUND=$blue
  typeset -g POWERLEVEL9K_RBENV_FOREGROUND=$pink
  typeset -g POWERLEVEL9K_RVM_FOREGROUND=$pink
  typeset -g POWERLEVEL9K_FVM_FOREGROUND=$cyan
  typeset -g POWERLEVEL9K_LUAENV_FOREGROUND=$blue
  typeset -g POWERLEVEL9K_JENV_FOREGROUND=$blue
  typeset -g POWERLEVEL9K_PLENV_FOREGROUND=$gray
  typeset -g POWERLEVEL9K_PERLBREW_FOREGROUND=$gray
  typeset -g POWERLEVEL9K_PHPENV_FOREGROUND=$peri
  typeset -g POWERLEVEL9K_SCALAENV_FOREGROUND=$pink
  typeset -g POWERLEVEL9K_HASKELL_STACK_FOREGROUND=$orange

  # ── Cloud and infrastructure ──────────────────────────────────────────
  typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_FOREGROUND=$peri
  typeset -g POWERLEVEL9K_TERRAFORM_OTHER_FOREGROUND=$cyan
  typeset -g POWERLEVEL9K_TERRAFORM_VERSION_FOREGROUND=$cyan
  typeset -g POWERLEVEL9K_AWS_DEFAULT_FOREGROUND=$orange
  typeset -g POWERLEVEL9K_AWS_EB_ENV_FOREGROUND=$mint
  typeset -g POWERLEVEL9K_AZURE_OTHER_FOREGROUND=$blue
  typeset -g POWERLEVEL9K_GCLOUD_FOREGROUND=$blue
  typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_DEFAULT_FOREGROUND=$blue

  # ── System and network ────────────────────────────────────────────────
  typeset -g POWERLEVEL9K_DISK_USAGE_NORMAL_FOREGROUND=$mint
  typeset -g POWERLEVEL9K_DISK_USAGE_WARNING_FOREGROUND=$yellow
  typeset -g POWERLEVEL9K_DISK_USAGE_CRITICAL_FOREGROUND=$pink
  typeset -g POWERLEVEL9K_RAM_FOREGROUND=$gray
  typeset -g POWERLEVEL9K_SWAP_FOREGROUND=$peri
  typeset -g POWERLEVEL9K_LOAD_NORMAL_FOREGROUND=$gray
  typeset -g POWERLEVEL9K_LOAD_WARNING_FOREGROUND=$sand
  typeset -g POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND=$orange
  typeset -g POWERLEVEL9K_CPU_ARCH_FOREGROUND=$orange
  typeset -g POWERLEVEL9K_PUBLIC_IP_FOREGROUND=$orange
  typeset -g POWERLEVEL9K_VPN_IP_FOREGROUND=$cyan
  typeset -g POWERLEVEL9K_IP_FOREGROUND=$cyan
  typeset -g POWERLEVEL9K_BATTERY_LOW_FOREGROUND=$pink
  typeset -g POWERLEVEL9K_BATTERY_{CHARGING,CHARGED}_FOREGROUND=$mint
  typeset -g POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND=$sand
  typeset -g POWERLEVEL9K_WIFI_FOREGROUND=$gray
  typeset -g POWERLEVEL9K_TIME_FOREGROUND=$gray

  # ── File managers and task trackers ───────────────────────────────────
  typeset -g POWERLEVEL9K_NORDVPN_FOREGROUND=$cyan
  typeset -g POWERLEVEL9K_RANGER_FOREGROUND=$sand
  typeset -g POWERLEVEL9K_YAZI_FOREGROUND=$sand
  typeset -g POWERLEVEL9K_NNN_FOREGROUND=$mint
  typeset -g POWERLEVEL9K_LF_FOREGROUND=$mint
  typeset -g POWERLEVEL9K_XPLR_FOREGROUND=$mint
  typeset -g POWERLEVEL9K_MIDNIGHT_COMMANDER_FOREGROUND=$sand
  typeset -g POWERLEVEL9K_TODO_FOREGROUND=$blue
  typeset -g POWERLEVEL9K_TIMEWARRIOR_FOREGROUND=$blue
  typeset -g POWERLEVEL9K_TASKWARRIOR_FOREGROUND=$blue
}
