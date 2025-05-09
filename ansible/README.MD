Utilisation de notre code ansible :

inventory.ini :
Il se compose des serveurs web qui vont être modifier par notre playbook.yml, il faut modifié les IP et la clé SSH dans ce document pour l'adapter à votre infrastructure.

inventorybdd.ini :
Il se compose du serveur de base de données qui vas être modifier par notre playbookbdd.yml, il faut modifié l'IP et la clé SSH dans ce document pour l'adapter à votre infrastructure.

playbook.yml :
Il se compose de l'installation de nginx et de php8.3, il configure aussi nginx pour le site s'appelant GREENSHOP, crée aussi le lien symbolique sur le reverse proxy et supprime le site par défaut de nginx. Modifie le db.php du site pour qu'il puisse se connecter à notre nouvelle base de données se trouvant sur une machine ec2 d'AWS.
A modifié la variable source_path qui contient les fichiers du site sur la machine ansible.

playbookbdd.yml :
Il se compose de l'installation et configuration de MariaDB, créer les utilisateurs local et externe, la base de données et les privililèges sur la base. Copie la sauvegarde de la bdd qui se trouve sur la machine ansible vers la machine de bdd. Importe la bdd dans mariadb. Modifie la configuration de mariadb en ouvrant le serveur /etc/mysql/mariadb.conf.d/50-server.cnf.
A adapter selon vos besoins : les variables suivantes ip_web1 ip_web2 ip_web3 se sont les IP de vos serveurs web. db_user : l'utilisateur de votre base de données, db_password le mot de passe de votre utilisateur, db_name : le nom de votre base de données, db_dump_path : la sauvegarde de la base de données qui se trouve sur votre machine ansible.
