# **************************************************************************** #
#                                                                              #
#                                                         .--.    No           #
#    scripts-initialisation-react.sh                     |o_o |    Pain        #
#                                                        |:_/ |     No         #
#    By: YohanGH <YohanGH@proton.me>                    //    ''     Code      #
#                                                      (|     | )              #
#    Created: 2024/03/25 15:13:28 by YohanGH           '__   _/_               #
#    Updated: 2024/03/27 14:31:56 by YohanGH          (___)=(___)              #
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

# Déplacement dans le répertoire de l'application React créée
echo "Déplacement dans le répertoire de l'application..."
cd my-react-app
if [ $? -ne 0 ]; then
  echo "Erreur lors du déplacement dans le répertoire de l'application React."
  exit 1
fi

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

# Création d'un dossier components pour les composants React
echo "Création du dossier components pour les composants React..."
mkdir -p src/components
if [ $? -ne 0 ]; then
  echo "Erreur lors de la création du dossier components."
  exit 1
fi

echo "Dossier components créé avec succès."

echo "Installation terminée avec succès."
