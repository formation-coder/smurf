# Comment peut-on serveir une application Web ?

Parlons d'abord adressage : 
 - Qu'est ce qu'une adresse IP (Internet Protocol) : adresse au format numérique => permet d'identifier une machine **sur un réseau**. On peut avoir différents type de réseau : publique et privé. Par exemple, votre réseau privé chez vous a généralement une adresse de la forme `192.168.0.xxx`. Votre machine a aussi une adresse locale qui permet de naviguer même si l'ordinateur n'est pas connecté : `127.0.0.1` qui est associé au nom de domaine `localhost`. 
 - Qu'est qu'un nom de domaine (et pourquoi) ? Nom qui sert à identifier un `serveur` => format destiné aux humains. Les noms de domaines sont associées à une adresse IP (en général, une ip publique, mais pas forcément). On peut configurer en local des noms de domaines (ou de serveur) dans le fichier `/etc/hosts`. 
 - Pour maintenir l'association IP/nom de domaines, il est nécessaire d'avoir un serveur de nom de domaine (DNS). 
 - Les domaines se lisent de droite à gauche : du plus général au pllus spécifique :    
   - exemple : google.com = domaine principal
             - maps.google.com = sous domaine maps
             - news.google.com = sous domaine news 
 - Les sous domaines peuvent pointer vers des adresses IP différentes du domaine principal. 
 - La notion `domaine` va être importante pour le protocole HTTP, notamment : la sécurité 
   - certificats 
   - cookies/sessions 

- Qu'est ce qu'un port ? 
  - on peut faire une analogie avec une porte d'un bureau proposant un service. ou encore une place dans un port de pêche
    - Chaque numéro de port est associé à un service particulier : 
      - 80 : http
      - 443 : https
      - 21 : ftp
      - 22 : ssh
      - 25: smtp
    - On considère que tous les ports < 1000 sont reservés, et ceux jusqu'à 65535 sont **libres**. 
    - On ne peut pas lancer deux services différents sur le même ports : par exemple, lancer ngninx et apache sur le port 80 en même temps. 

- Que sont les protocoles TCP et UDP ? 
  - UDP : User Datagram Protocol => uni directionnel, sans connexion : transmet des paquets sans se préocupper de la réception
  - TCP : Transmission Control Protocol => établi une connexion, et défini un moyen entre les 2 parties d'assurer que les paquets sont transmits et réceptionnés dans l'ordre et sans erreur. 
  
## Comment fonctionne une application Web ? 
 - Un navigateur Web ( client )
   - Responsable du **rendu** des pages Web => interprête le code HTML (pour générer la page) et le CSS pour sa mise en forme
   - Interprête aussi le javascript => c'est l'aspect **dynamique**. Le JS dans le navigateur peut (entre autre)
     - intéragir avec le DOM (Documnet Object Model = representation du HTML en mémoire), et son style 
     - des requêtes asynchrone AJAX/Fetch, Axios : interagir avec un serveur sans avoir à recharger la page
   - Emêt des **requêtes HTTP** et traite des **réponses HTTP**. 
 - Un serveur Web (serveur)
 - Une base de donnée (optionnelle)



## Quelles sont les différentes architectures possibles pour une application Web ? 
 - Cordelia :  Laravel : Archi MCV => config apache : 

### Pour le back : 
 - lancer un serveur en développement : 
   - on se positionne à la racine de notre projet
   ```sh
   # php -S serverName:port
    php -S localhost:8000
   ```
   ou si on utilise laravel : 
   ```sh
    php artisan serve
   ```
  - Avantages : 
    - Facile à mettre en place (à utiliser)
    - Choisir les ports rapidement
    - Les erreurs s'affichent directement dans la console
    - Plus facile à debuger
  - Inconvenients :
    - il faut le retaper à chaque fois
    - uniquement pour le développement, pas prêt à déployer en production
    - il faut faire attention à la gestion des url (localhost:8000 n'est pas cool en production)

 - Utiliser un serveur Web (Apache ou Nginx)
  - Avantages : 
    - On peut utiliser notre site sur le port 80 (si on configure bien)
    - on peut utiliser un nom de serveur et de domaine prêt pour le déployement en production
    - on peut (mais c'est compliqué et on a pas encore vu) sécuriser avec HTTPS
  - Inconvenients :
    - il faut connaître la façon dont s'écrivent les fichiers de configurations
    - il faut aller chercher les log en tant qu'utilisateur root (dans `/var/log/apache2/error.log`)
    - risque de conflit si on essaye d'utiliser apache et ngninx en même temps 


En php, durant la phase de développement (:warning: :warning:**développement uniquement : ne pas le faire lorsque vous déployez un site en production** :warning: :warning:), vous pouvez indiquer à php d'afficher les erreurs afin de ne pas avoir à aller les chercher dans les logs apache : 
 ```php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
```
À mettre dans les fichiers php que vous testez.

## Étude de cas : 
On a un projet dans lequel les fichiers sont organisés comme suit : 
 - backend
   - `bdd.php`
   - `hello.php` => renvoi un json `{message:"Hello"}`
 - frontend
   - `css/main.css`
   - `js/main.js` => effectue une requête fetch pour recevoir et afficher le JSON `{message:'Hello'}`
   - `index.html` => inclut le fichier `js/main.js`

Comment configuer tout cela ?


## Cas particulier : 
 - 
