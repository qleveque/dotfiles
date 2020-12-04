# Kotlin
curl -s https://get.sdkman.io | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install kotlin
# LSP
../kotlin-language-server/gradlew server:build

