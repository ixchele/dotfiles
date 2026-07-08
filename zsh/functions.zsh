clone-from() {
	if [ -z "$1" ] || [ -z "$2" ]; then
		echo "Usage: clone-from <user> <repo>"
		return 1
	fi
	git clone "git@github.com:$1/$2.git"
}

# Fonction d'installation en cascade (Mamba -> Brew -> Cargo)
binstall() {
    if [[ -z "$1" ]]; then
        echo "❌ Usage: binstall <package_name>"
        return 1
    fi

    local pkg="$1"
    echo "🔄 Tentative d'installation de '$pkg'..."

    # 1. Test avec Micromamba (via conda-forge)
    if command -v micromamba &> /dev/null; then
        echo "🐍 Essai avec Micromamba..."
        # On utilise -y pour accepter automatiquement et on redirige les erreurs
        if micromamba install -c conda-forge -y "$pkg" 2>/dev/null; then
            echo "✅ '$pkg' installé avec succès via Micromamba !"
            return 0
        else
            echo "⚠️ Micromamba n'a pas pu installer '$pkg'. Passage au suivant..."
        fi
    fi

    # 2. Test avec Homebrew
    if command -v brew &> /dev/null; then
        echo "🍺 Essai avec Homebrew..."
        if brew install "$pkg" 2>/dev/null; then
            echo "✅ '$pkg' installé avec succès via Homebrew !"
            return 0
        else
            echo "⚠️ Homebrew n'a pas pu installer '$pkg'. Passage au suivant..."
        fi
    fi

    # 3. Test avec Cargo
    if command -v cargo &> /dev/null; then
        echo "🦀 Essai avec Cargo..."
        if cargo install "$pkg" 2>/dev/null; then
            echo "✅ '$pkg' installé avec succès via Cargo !"
            return 0
        else
            echo "❌ Cargo n'a pas pu installer '$pkg'."
        fi
    fi

    echo "❌ Échec : Aucun gestionnaire n'a trouvé ou réussi à installer '$pkg'."
    return 1
}
