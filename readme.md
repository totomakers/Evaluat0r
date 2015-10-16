# Evaluat0r : Logicel d'évaluation (ENI 2015)
---

#### Prérequis :

+ composer
+ git
+ npm

#### Installer l'application :

+ Lancer la commande `composer update` dans vote répertoire
+ Lancer la commande `npm install` dans votre répertoire
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

#### Dépendances :

+ Bootstrap : UI kit reponsive 
+ JQuery : Le javascript, mais en mieux.

----


## Laravel 5

Laravel est le le framework le php le plus puissant du moment avec Symfony.
Simple d'utilisation et efficace, ce framework répond a toutes nos attentes.
La documentation est disponible [ici](http://laravel.com/docs/5.1).

## Bower

Bower permet de facilement installer des dépendances pour notre site web.
Les packages sont disponible [ici](http://bower.io/search/)

+ Pour installer un package il suffit d'executer la commande `bower install [packagename] --save`

+ Pour récuper tout vos package après une nouvelle installation `bower install`
+ Pou mettre à jour `bower update`

----

### Astuces

+ [Github Markdown Editor](https://jbt.github.io/markdown-editor/)