# **************************************************************************** #
#                                                                              #
#                                                         .--.    No           #
#    scripts-initialisation-react.sh                     |o_o |    Pain        #
#                                                        |:_/ |     No         #
#    By: YohanGH <YohanGH@proton.me>                    //    ''     Code      #
#                                                      (|     | )              #
#    Created: 2024/03/25 15:13:28 by YohanGH           '__   _/_               #
#    Updated: 2024/07/04 12:24:29 by YohanGH          (___)=(___)              #
#                                                                              #
# **************************************************************************** #

#!/usr/bin/env bash

# Mise à jour de npm à la dernière version pour éviter des problèmes potentiels
echo "Mise à jour de npm..."
npm install -g npm
if [ $? -ne 0 ]; then
  echo "Erreur lors de la mise à jour de npm."
  exit 1
fi

# Création d'une nouvelle application React avec Vite
echo "Création d'une nouvelle application React avec Vite..."
npm create vite@latest my-react-app -- --template react
if [ $? -ne 0 ]; then
  echo "Erreur lors de la création de l'application React avec Vite."
  exit 1
fi

# déplacement dans le répertoire de l'application react créée
echo "déplacement dans le répertoire de l'application..."
cd my-react-app
if [ $? -ne 0 ]; then
  echo "erreur lors du déplacement dans le répertoire de l'application react."
  exit 1
fi

# Suppression du répertoire public et du fichier vite.svg générés par Vite
echo "Suppression du répertoire public et du fichier vite.svg générés par Vite..."
rm -rf public
check_last_command

# Installation des dépendances dans le répertoire de l'application React
echo "Installation des dépendances de l'application React..."
npm install
if [ $? -ne 0 ]; then
  echo "Erreur lors de l'installation des dépendances de l'application React."
  exit 1
fi

# Installation de Prettier pour le formatage de code
echo "Installation de Prettier..."
npm install prettier --save-dev
if [ $? -ne 0 ]; then
  echo "Erreur lors de l'installation de Prettier."
  exit 1
fi

# Installation de ESLint pour l'analyse de code
echo "Installation de ESLint..."
npm install eslint --save-dev
if [ $? -ne 0 ]; then
  echo "Erreur lors de l'installation de ESLint."
  exit 1
fi

# Installation globale de Legally pour vérifier les licences des dépendances
echo "Installation globale de Legally..."
npm install -g legally
if [ $? -ne 0 ]; then
  echo "Erreur lors de l'installation globale de Legally."
  exit 1
fi

# Création dossier clients components pour les composants React
echo "Création du dossier components pour les composants React..."
# Création des dossiers côté client
echo "Création des dossiers côté client..."
mkdir -p client/public
mkdir -p client/src/assets/images
mkdir -p client/src/components
mkdir -p client/src/pages
mkdir -p client/src/handler
mkdir -p client/src/utils
mkdir -p client/src/services
mkdir -p client/src/context
if [ $? -ne 0 ]; then
  echo "Erreur lors de la création des dossiers côté client."
  exit 1
fi

echo "Dossiers côté client créés avec succès."
if [ $? -ne 0 ]; then
  echo "Erreur lors de la création du dossier components."
  exit 1
fi

echo "Dossier components créé avec succès."

# Création des dossiers côté serveur
echo "Création des dossiers côté serveur..."
mkdir -p server/app/Controller
mkdir -p server/app/routes
mkdir -p server/app/middleware
mkdir -p server/database/fixtures
mkdir -p server/database/models
mkdir -p server/config
if [ $? -ne 0 ]; then
  echo "Erreur lors de la création des dossiers côté serveur."
  exit 1
fi

echo "Dossiers côté serveur créés avec succès."

# Installer les dépendances pour les tests
npm install --save-dev vitest jsdom @testing-library/react
npm install --save-dev @testing-library/user-event

# Créer le dossier de test s'il n'existe pas
mkdir -p test

# Créer le fichier setup.js dans le dossier de test et y ajouter le contenu requis
cat <<EOF >test/setup.js
import {afterEach} from "vitest";
import {cleanup} from "@testing-library/react";

afterEach(() => {
    cleanup()
})
EOF

# Rajouter le package npm install axios
# ICI Mettre a jours

# Vérifier si vite.config.js existe, sinon le créer ou le mettre à jour
if [ ! -f vite.config.js ]; then
    cat <<EOF >vite.config.js
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  test: {
    environment: 'jsdom',
    setupFiles: './test/setup.js'
  }
})
EOF
else
    # Si vite.config.js existe, vérifier si la configuration de test est déjà présente
    if ! grep -q "test: {" vite.config.js; then
        # Ajouter la configuration de test après plugins: [react()],
        awk '/plugins: \[react\(\)\],/{print;print "  test: {\n    environment: '\''jsdom'\'',\n    setupFiles: '\''./test/setup.js'\''\n  }";next}1' vite.config.js > vite.config.tmp.js && mv vite.config.tmp.js vite.config.js
    fi
fi || error "Impossible de créer ou de mettre à jour vite.config.js."

# Installation de Express pour le serveur
echo "Installation de Express..."
npm install express
if [ $? -ne 0 ]; then
  echo "Erreur lors de l'installation de Express."
  exit 1
fi

# Déplace le fichier index.html
echo "déplacement du fichier index.html vers client/public/..."
mv index.html client/public/
if [ $? -ne 0 ]; then
  echo "erreur lors du déplacement du fichier index.html."
  exit 1
fi

# Déplacement des fichiers
mv src/App.css client/src/
if [ $? -ne 0 ]; then
  echo "erreur lors du déplacement de App.css."
  exit 1
fi

mv src/App.jsx client/src/
if [ $? -ne 0 ]; then
  echo "erreur lors du déplacement de App.jsx."
  exit 1
fi

rm -rf src/assets/react.svg client/src/assets/
if [ $? -ne 0 ]; then
  echo "erreur lors du déplacement de react.svg."
  exit 1
fi

mv src/index.css client/src/
if [ $? -ne 0 ]; then
  echo "erreur lors du déplacement de index.css."
  exit 1
fi

mv src/main.jsx client/src/
if [ $? -ne 0 ]; then
  echo "erreur lors du déplacement de main.jsx."
  exit 1
fi

# Suppression du répertoire src s'il est vide
rmdir src
if [ $? -ne 0 ]; then
  echo "le répertoire src n'a pas pu être supprimé, il peut contenir d'autres fichiers."
fi

# Création de client/.env.sample
echo "création de client/.env.sample..."
touch client/.env.sample
if [ $? -ne 0 ]; then
  echo "erreur lors de la création de client/.env.sample."
  exit 1
fi

# Création de server/.env.sample
echo "création de server/.env.sample..."
touch server/.env.sample
if [ $? -ne 0 ]; then
  echo "erreur lors de la création de server/.env.sample."
  exit 1
fi


# Installation des librairies
echo "déplacement dans le répertoire client..."
cd client
if [ $? -ne 0 ]; then
  echo "erreur lors du déplacement dans le répertoire client."
  exit 1
fi

# Initialisation du projet npm
echo "initialisation du projet npm..."
npm init -y
if [ $? -ne 0 ]; then
  echo "erreur lors de l'initialisation du projet npm."
  exit 1
fi


# Installation de MUI pour l'interface utilisateur
echo "Installation de MUI..."
npm install @mui/material @emotion/react @emotion/styled
if [ $? -ne 0 ]; then
  echo "Erreur lors de l'installation de MUI."
  exit 1
fi

# Installation de react-toastify pour les notifications
echo "Installation de react-toastify..."
npm install react-toastify
if [ $? -ne 0 ]; then
  echo "Erreur lors de l'installation de react-toastify."
  exit 1
fi

echo "Librairies côté client installées avec succès."

# Remonte d'un niveau
echo "remonte d'un niveau..."
cd ..
if [ $? -ne 0 ]; then
  echo "erreur lors de la remontée d'un niveau."
  exit 1
fi

# Déplacement dans le répertoire server
echo "déplacement dans le répertoire server..."
cd server
if [ $? -ne 0 ]; then
  echo "erreur lors du déplacement dans le répertoire server."
  exit 1
fi

# Initialisation du projet npm
echo "initialisation du projet npm..."
npm init -y
if [ $? -ne 0 ]; then
  echo "erreur lors de l'initialisation du projet npm."
  exit 1
fi

# Installation de bcryptjs pour le hachage des mots de passe
echo "Installation de bcryptjs..."
npm install bcryptjs
if [ $? -ne 0 ]; then
  echo "Erreur lors de l'installation de bcryptjs."
  exit 1
fi

# Installation de jsonwebtoken pour la gestion des tokens JWT
echo "Installation de jsonwebtoken..."
npm install jsonwebtoken
if [ $? -ne 0 ]; then
  echo "Erreur lors de l'installation de jsonwebtoken."
  exit 1
fi

# Installation de cookie-parser pour la gestion des cookies
echo "Installation de cookie-parser..."
npm install cookie-parser
if [ $? -ne 0 ]; then
  echo "Erreur lors de l'installation de cookie-parser."
  exit 1
fi

echo "Librairies côté serveur installées avec succès."

# Remonte d'un niveau
echo "remonte d'un niveau..."
cd ..
if [ $? -ne 0 ]; then
  echo "erreur lors de la remontée d'un niveau."
  exit 1
fi

# Affiche l'arborescence des fichiers en excluant les répertoires node_modules et les fichiers cachés
echo "affiche l'arborescence des fichiers..."
tree -I 'node_modules|.*' .
if [ $? -ne 0 ]; then
  echo "erreur lors de l'affichage de l'arborescence des fichiers."
  exit 1
fi

echo "Commande de test ajoutée avec succès dans package.json."

echo "Installation terminée avec succès."
