# Gestion d'un serveur back PHP et d'un serveur front avec VueCli. 

Cette petite application va nous permettre : 
 -  d'enregistrer un utilisateur
 -  de se connecter/déconnecter
 -  de charger une image une de profil

Contrainte : la connexion devra être persistante, en utilisant le mécanisme de session de php (on appelle cela une authentification statefull). Pour creuser un peu notamment sur les problématiques de sécurité : https://www.php.net/manual/fr/book.session.php

Selon comment on configure nos serveurs, nous risquons de rencontrer plusieurs problèmes : 
 - CORS : Cross-Origin Ressource Sharing => on essaye d'obtenir des ressources qui proviennent d'un autre seveur que celui qui sur lequel on navigue. 
 - Gestion du cookie de session
 - Gestion des permissions/droits sur le répertoire d'upload de nos fichiers

Pour réussir à surmonter tous ces problèmes, on va poser comme condition que nos 2 serveurs doivent être sur le même domaine principal `smurf.local`. 

On choisi donc les sous domaines pour : 
 - le front : `www.smurf.local`
 - le back : `back.smurf.local`

La structure du projet contient un répertoire
 - back
 - front 

Bien entendu, il y aura une base de données


## Le front
Installation et configuration de vue.js : on se positionne dans le répertoire `front`  
```sh
cd front
npm install @vue/cli
```
Si ça ne fonctionne pas, essayez 
```sh 
npm init 
npm install @vue/cli
```

```sh
node node_modules/@vue/cli/bin/vue.js create app
```

Pour ce projet, on utilisera vue3

Un dossier app qui contriendra notre projet vuejs est créé. 
Le sources seront donc dans : 
`front/app/src` et lors d'un build, l'application compilée sera dans `front/app/dist`

On peut utiliser vue en développement : 
```sh
cd app
npm run serve
```

Vue nous indique que notre application est accessible à l'url suivante : 
```sh
  App running at:
  - Local:   http://localhost:8080/ 
  - Network: http://192.168.3.144:8080/
```
On voit que le serveur tourne sur l'url `localhost`. Or nous souhaitons qu'il soit sur le domaine `www.smurf.local`. Pour cela, on va povoir indiquer à vue le nom d'hôte que l'on souhaite (dans le fichier `app/vue.config.js`) : 
```js
module.exports = {
    devServer: {
        host: 'www.smurf.local',
    }
};
```
Pour pouvoir accéder à `www.smurf.local`, il faut renseigner le fichier `/etc/hosts` pour lier l'adresse locale à ce domaine : 
```sh
127.0.1.1   www.smurf.local
```

## Compilation du projet (simulation d'une mise en production)
```sh
npm run build
```
ce qui donne : 
```sh
 DONE  Build complete. The dist directory is ready to be deployed.
 INFO  Check out deployment instructions at https://cli.vuejs.org/guide/deployment.html
```
La version de développement est maintenant disponible dans le répertoire `dist` (pour distribution). 

On peut (pour tester seulement) ouvrir `index.html`

### Configuration d'apache pour les builds
```xml
<VirtualHost *:80>
        ServerName www.smurf.local

        ServerAdmin webmaster@localhost
        DocumentRoot "/home/niko/Documents/cours/simplon/DWWM-2/activites/backandfront/front/app/dist"

        <Directory "/home/niko/Documents/cours/simplon/DWWM-2/activites/backandfront/front/app/dist">
                AllowOverride
                Require all granted
                Options Indexes FollowSymLinks
        </Directory>

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```
On peut accéder à notre serveur front en production sur l'url http://www.smurf.local
Si on modifie des fichiers dans src, les modifications ne sont pas prises en compte sur notre serveur de production. 

## Backend : 
création de la bdd dans le fichier `back/bdd.sql`. 
Le fichier de config propre à la connexion pour php : `bdd.php **que l'on ajoute au fichier `.gitignore`; 