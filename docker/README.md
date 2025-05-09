Docker

Le fichier Dockerfile contient les instructions pour créer l'image Docker de l'application web. Le fichier docker-compose.yml gère les services Docker, notamment la base de données et l'application web. Enfin, greenshop.conf configure le serveur Apache utilisé par l'application.

Pour lancer l'application en local, vous pouvez utiliser les commandes suivantes :

Construire l'image Docker : docker build -t nom_image .

Lancer le conteneur : docker run -d -p 80:80 nom_image

Lancer tous les services : docker-compose up -d

Pour arreter les services il faudra utiliser : docker-compose down -v

Jenkins

Jenkins automatise le processus de déploiement via un fichier Jenkinsfile. Ce fichier décrit les étapes du pipeline CI/CD, notamment :

Récupération du code source depuis GitHub.

Construction de l'image Docker de l'application.

Connexion à DockerHub pour envoyer l'image.

Déploiement automatique via Docker Compose.

Les principales commandes pour gérer Jenkins sont :

Démarrer Jenkins : sudo systemctl start jenkins

Arrêter Jenkins : sudo systemctl stop jenkins

Redémarrer Jenkins : sudo systemctl restart jenkins

Jenkins est configuré pour utiliser un Webhook GitHub, ce qui permet de déclencher automatiquement le pipeline à chaque modification du code source.
Dans Jenkins, nous avons configuré le SCM (Source Control Management) pour récupérer automatiquement les fichiers depuis GitHub.
Un trigger a été ajouté pour déclencher le pipeline à chaque push sur le dépôt.

Déploiement

Le déploiement se fait automatiquement dès qu'une modification est poussée sur GitHub. Jenkins s'occupe de construire l'image Docker, de la pousser sur DockerHub et de lancer les services avec Docker Compose.





