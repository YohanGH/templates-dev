# **************************************************************************** #
#                                                                              #
#                                                         .--.    No           #
#    initialisation_npm.sh                               |o_o |    Pain        #
#                                                        |:_/ |     No         #
#    By: YohanGH <YohanGH@proton.me>                    //    ''     Code      #
#                                                      (|     | )              #
#    Created: 2024/03/19 10:48:02 by YohanGH           '__   _/_               #
#    Updated: 2024/03/19 10:59:35 by YohanGH          (___)=(___)              #
#                                                                              #
# **************************************************************************** #

#!/usr/bin/env bash

#!/bin/bash

# Mise à jour de npm à la dernière version pour éviter des problèmes potentiels
echo "Mise à jour de npm..."
npm install -g npm
if [ $? -ne 0 ]; then
  echo "Erreur lors de la mise à jour de npm."
  exit 1
fi

# Initialisation du projet
echo "Initialisation du projet..."
npm init -y
if [ $? -ne 0 ]; then
  echo "Erreur lors de l'initialisation du projet."
  exit 1
fi
echo "Initialisation réussite."

echo "Installation des dépendances du projet..."
# Installe les dépendances définies dans package.json sans demander de confirmation
npm install --yes
if [ $? -ne 0 ]; then
  echo "Erreur lors de l'installation des dépendances du projet."
  exit 1
fi

echo "Installation de Prettier..."
# Installe Prettier pour le formatage de code
npm install prettier
if [ $? -ne 0 ]; then
  echo "Erreur lors de l'installation de Prettier."
  exit 1
fi

echo "Installation de ESLint..."
# Installe ESLint pour l'analyse de code
npm install eslint
if [ $? -ne 0 ]; then
  echo "Erreur lors de l'installation de ESLint."
  exit 1
fi

echo "Installation globale de Legally..."
# Installe le paquet legally globalement pour vérifier les licences des dépendances
npm install -g legally
if [ $? -ne 0 ]; then
  echo "Erreur lors de l'installation globale de Legally."
  exit 1
fi

echo "Installation terminée avec succès."

