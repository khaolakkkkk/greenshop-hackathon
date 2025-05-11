provider.tf
Ce fichier configure le fournisseur AWS, spécifiant la région de déploiement. Il établit le lien entre Terraform et le compte AWS.

vpc.tf
Il définit le VPC principal, incluant son CIDR block et l'activation de la résolution DNS. Ce réseau virtuel isolé est la base de toute l’infrastructure.

subnet.tf
Ce fichier crée les sous-réseaux publics et privés dans différentes zones de disponibilité. Chaque sous-réseau est destiné à héberger des composants spécifiques (web, BDD, etc.).

route.tf
Il configure les tables de routage pour diriger le trafic interne et externe via l'Internet Gateway ou le NAT Gateway. Les sous-réseaux y sont associés selon leur nature (public/privé).

internet_gateway.tf
Ce fichier déclare l'Internet Gateway nécessaire pour permettre aux sous-réseaux publics d'accéder à Internet. Il est attaché au VPC.

nat_gateway.tf
Il crée un NAT Gateway pour que les instances en sous-réseau privé puissent accéder à Internet sans être exposées directement. Il utilise une Elastic IP allouée au préalable.

elasticip.tf
Ce fichier alloue une adresse IP élastique (EIP) dans AWS. Cette EIP est utilisée par le NAT Gateway pour sortir vers Internet.

security_groups.tf
Il définit des règles de sécurité (Security Groups) pour chaque type de machine (web, BDD, bastion...). Chaque groupe restreint ou autorise le trafic selon les besoins.

key_pair.tf
Il crée une paire de clés SSH pour accéder aux instances EC2. La clé publique est injectée dans les machines au moment du déploiement.
Pour récupérer la clé créer il faut faire cette commande : terraform output -raw private_key_pem > admin.pem
Attribution des droits :  chmod 400 admin.pem

instances.tf
Ce fichier déploie les différentes instances EC2 (web, BDD, ansible, reverse proxy). Chaque instance est placée dans le bon sous-réseau, avec les bons groupes de sécurité et une configuration user_data si nécessaire.
