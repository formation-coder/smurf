<?php
    // Ce fichier renvoie un json de la forme {connected:true, pseudo: pseudodelutilisateur}

    //On teste si l'utilisateur est connecté. 
    //La connexion est une connexion statefull coté serveur, dont la persistence est assurée par un mécanisme de session
    session_start();
    if(!empty($_SESSION['pseudo'])) { 
        // L'utilisateur a renvoyé un cookie de session 
        //qui permet à PHP de retrouver la variable 'pseudo' pour cet utilisateur dans le tableau $_SESSION
        echo json_encode(["connected" => true, "pseudo" => $_SESSION['pseudo']]); 
    } else {
        echo json_encode(["connected" => false]); 
    }