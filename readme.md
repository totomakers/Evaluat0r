# Evaluat0r : Logicel d'évaluation (ENI 2015)
---

#### Prérequis :

+ composer
+ git
+ npm

#### Installer l'application :

+ Lancer la commande `composer update` dans vote répertoire
+ Lancer la commande `bower update` dans votre répertoire
+ Installer les SQL du dossier SQL
+ Lancer la commande `php artisan key:generate`
+ Copier `.env.example` et le renommer en `.env` et le paramétrer


#### Lancer l'environnement de test :

+ Lancer la commande `php artisan serv`


#### Environnement de production :

+ Créer un symlink vers le repertoire publique
	+ Windows : `mklink /d "{/path/to/link-name}" "{/path/folder/linked}"`
	+ Linux : `ln -s {/path/to/file-name} {link-name}`

