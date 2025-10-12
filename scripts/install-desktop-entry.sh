#!/bin/bash

# Modified version of omarchy-tui-install
# Allows creating both TUI and Application desktop entries

if [ "$#" -lt 3 ]; then
  echo -e "\e[32mLet's create an app shortcut you can start with the launcher.\n\e[0m"
  APP_TYPE=$(gum choose --header "Application type" "TUI (Terminal App)" "GUI (Desktop App)")
  APP_NAME=$(gum input --prompt "Name> " --placeholder "My App")
  APP_EXEC=$(gum input --prompt "Launch Command> " --placeholder "e.g. lazydocker or firefox")
  ICON_URL=$(gum input --prompt "Icon URL> " --placeholder "See https://dashboardicons.com (must use PNG!)")
  WINDOW_STYLE=""
  if [[ "$APP_TYPE" == "TUI (Terminal App)" ]]; then
    WINDOW_STYLE=$(gum choose --header "Window style" float tile)
  fi
else
  APP_TYPE="$1"
  APP_NAME="$2"
  APP_EXEC="$3"
  ICON_URL="$4"
  WINDOW_STYLE="${5:-float}"
fi

if [[ -z "$APP_NAME" || -z "$APP_EXEC" || -z "$ICON_URL" ]]; then
  echo "You must set app name, app command, and icon URL!"
  show-spinner.sh
  exit 1
fi

ICON_DIR="$HOME/.local/share/applications/icons"
DESKTOP_FILE="$HOME/.local/share/applications/$APP_NAME.desktop"

if [[ ! "$ICON_URL" =~ ^https?:// ]] && [ -f "$ICON_URL" ]; then
  ICON_PATH="$ICON_URL"
else
  ICON_PATH="$ICON_DIR/$APP_NAME.png"
  mkdir -p "$ICON_DIR"
  if ! curl -sL -o "$ICON_PATH" "$ICON_URL"; then
    echo "Error: Failed to download icon."
    exit 1
  fi
fi

if [[ "$APP_TYPE" == "TUI (Terminal App)" ]]; then
  if [[ $WINDOW_STYLE == "float" ]]; then
    APP_CLASS="TUI.float"
  else
    APP_CLASS="TUI.tile"
  fi

  EXEC_CMD="kitty --class=$APP_CLASS -e $APP_EXEC"
  TERMINAL=false
else
  EXEC_CMD="$APP_EXEC"
  TERMINAL=false
fi

cat >"$DESKTOP_FILE" <<EOF
[Desktop Entry]
Version=1.0
Name=$APP_NAME
Comment=$APP_NAME
Exec=$EXEC_CMD
Terminal=$TERMINAL
Type=Application
Icon=$ICON_PATH
StartupNotify=true
EOF

chmod +x "$DESKTOP_FILE"

echo -e "\e[32mSuccessfully created desktop entry: $DESKTOP_FILE\e[0m"
echo -e "You can now start \e[33m$APP_NAME\e[0m from your application launcher.\n"

show-spinner.sh
