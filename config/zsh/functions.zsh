extract() {
  case "$1" in
    *.tar.bz2)  tar xjf "$1"  ;;
    *.tar.gz)   tar xzf "$1"  ;;
    *.zip)      unzip "$1"    ;;
    *.gz)       gunzip "$1"   ;;
    *.rar)      unrar x "$1"  ;;
    *)          echo "don't know how to extract '$1'" ;;
  esac
}
