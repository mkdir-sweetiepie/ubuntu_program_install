#! /bin/bash
# Install Development Tools for Ubuntu

# Copyright 2024 mkdir-sweetiepie
# https://github.com/mkdir-sweetiepie/ubuntu_program_install
# Licensed under the MIT License

function custom_echo() {
  text=$1                     # 첫 번째 인자는 출력할 텍스트입니다.
  color=$2                    # 두 번째 인자는 출력할 색상입니다.

  case $color in
  "red")
    echo -e "\033[31m[RO:BIT] $text\033[0m" # 빨간색으로 출력
    ;;
  "green")
    echo -e "\033[32m[RO:BIT] $text\033[0m" # 초록색으로 출력
    ;;
  "yellow")
    echo -e "\033[33m[RO:BIT] $text\033[0m" # 노란색으로 출력
    ;;
  *)
    echo "$text"
    ;;
  esac
}

loading_animation() {
  local interval=1                                    # 프레임 전환 간격을 설정 (0.1초 단위, 0.1초로 표시됨)
  local duration=30                                   # 애니메이션 총 지속 시간 (초 단위)
  local bar_length=$(tput cols)                       # 터미널 창의 너비를 가져옴
  local total_frames=$((duration * interval))         # 총 프레임 수를 계산
  local frame_chars=("█" "▉" "▊" "▋" "▌" "▍" "▎" "▏") # 로딩 애니메이션에 사용할 프레임 문자 배열

  for ((i = 0; i <= total_frames; i++)); do
    local frame_index=$((i % ${#frame_chars[@]}))     # 현재 프레임 문자 인덱스를 계산
    local progress=$((i * bar_length / total_frames)) # 진행 상황을 터미널 너비로 변환
    local bar=""
    for ((j = 0; j < bar_length; j++)); do
      if ((j <= progress)); then
        bar+="${frame_chars[frame_index]}" # 진행된 부분에 해당하는 프레임 문자 추가
      else
        bar+=" " # 진행되지 않은 부분에는 공백 추가
      fi
    done
    printf "\r\033[32m%s\033[0m" "$bar" # 초록색으로 출력
    sleep 0.$interval                   # 다음 프레임까지 대기 (여기서는 0.1초)
  done

  printf "\n"
}

text_art="

░█▀▀█ ░█▀▀▀█ ▄ ░█▀▀█ ▀█▀ ▀▀█▀▀ 　 ░█▀▄▀█ ░█─▄▀ ░█▀▀▄ ▀█▀ ░█▀▀█ 
░█▄▄▀ ░█──░█ ─ ░█▀▀▄ ░█─ ─░█── 　 ░█░█░█ ░█▀▄─ ░█─░█ ░█─ ░█▄▄▀ 
░█─░█ ░█▄▄▄█ ▀ ░█▄▄█ ▄█▄ ─░█── 　 ░█──░█ ░█─░█ ░█▄▄▀ ▄█▄ ░█─░█ 

░█▀▀▀█ ░█──░█ ░█▀▀▀ ░█▀▀▀ ▀▀█▀▀ ▀█▀ ░█▀▀▀ ░█▀▀█ ▀█▀ ░█▀▀▀ 
─▀▀▀▄▄ ░█░█░█ ░█▀▀▀ ░█▀▀▀ ─░█── ░█─ ░█▀▀▀ ░█▄▄█ ░█─ ░█▀▀▀ 
░█▄▄▄█ ░█▄▀▄█ ░█▄▄▄ ░█▄▄▄ ─░█── ▄█▄ ░█▄▄▄ ░█─── ▄█▄ ░█▄▄▄ 

░█─░█ ░█▀▀█ ░█─░█ ░█▄─░█ ▀▀█▀▀ ░█─░█ 　 ░█▀▀▀█ ░█▀▀▀ ▀▀█▀▀ ░█─░█ ░█▀▀█ 
░█─░█ ░█▀▀▄ ░█─░█ ░█░█░█ ─░█── ░█─░█ 　 ─▀▀▀▄▄ ░█▀▀▀ ─░█── ░█─░█ ░█▄▄█ 
─▀▄▄▀ ░█▄▄█ ─▀▄▄▀ ░█──▀█ ─░█── ─▀▄▄▀ 　 ░█▄▄▄█ ░█▄▄▄ ─░█── ─▀▄▄▀ ░█───

"

terminal_width=$(tput cols)                             # 현재 터미널의 너비(컬럼 수)를 가져옵니다.
padding_length=$(((terminal_width - ${#text_art}) / 2)) # 중앙 패딩
padding=$(printf "%*s" $padding_length "")

echo -e "\033[38;5;208m$padding$text_art\033[0m"           # 텍스트 아트 출력
custom_echo "GITHUB : github.com/mkdir-sweetiepie" "green" # 깃헙 주소 출력
custom_echo "RO:BIT 18th JiHyeon Hong" "green"             # 이름 출력
custom_echo "Ubuntu Development Tools Installer" "green"   # 우분투 프로그램 정보 출력

loading_animation

# 설치 옵션 선택
echo ""
custom_echo "Please select which applications to install:" "yellow"
echo "1) Terminator"
echo "2) Google Chrome"
echo "3) Visual Studio Code"
echo "4) GitKraken"
echo "0) Exit"
echo ""

read -p "Enter your choices (separated by spaces, e.g., '1 2 3'): " choices

# 기본 업데이트
if [[ $choices != "0" ]]; then
  custom_echo "Updating package lists..." "green"
  sudo apt update && sudo apt upgrade -y
fi

# 선택한 항목 설치
for choice in $choices; do
  case $choice in
  1)
    custom_echo "Installing Terminator..." "green"
    sudo apt install -y terminator
    custom_echo "Terminator installed successfully!" "green"
    ;;
  2)
    custom_echo "Installing Google Chrome..." "green"
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install -y ./google-chrome-stable_current_amd64.deb
    rm google-chrome-stable_current_amd64.deb
    custom_echo "Google Chrome installed successfully!" "green"
    ;;
  3)
    custom_echo "Installing Visual Studio Code..." "green"
    sudo apt-get install -y wget gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/packages.microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    sudo apt update
    sudo apt install -y code
    custom_echo "Visual Studio Code installed successfully!" "green"
    ;;
  4)
    custom_echo "Installing GitKraken..." "green"
    wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
    sudo apt install -y ./gitkraken-amd64.deb
    rm gitkraken-amd64.deb
    custom_echo "GitKraken installed successfully!" "green"
    ;;
  0)
    custom_echo "Installation cancelled." "red"
    exit 0
    ;;
  *)
    custom_echo "Invalid option: $choice" "red"
    ;;
  esac
done

custom_echo "Installation complete!" "green"
loading_animation

exit 0
