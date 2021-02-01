# Kotlin
curl -s https://get.sdkman.io | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install kotlin

# LSP
git clone https://github.com/fwcd/kotlin-language-server ~/.kotlin-language-server
~/.kotlin-language-server/gradlew server:build

