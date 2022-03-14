# Exemple de calculette en [notation postfixée](https://fr.wikipedia.org/wiki/Notation_polonaise_inverse)

La calculette utilise le générateur d'analyseur lexical 
[JFlex](https://jflex.de/).

La calculette fonctionne de façon simple, en utilisant une pile : 
- quand un entier est reconnu, il est ajouté dans la pile
- quand un opérateur est reconnu, il est appliqué sur 
  les éléments qui sont au sommet de la pile puis ceux-ci sont 
  remplacés par le résultat de l'opération. 
- quand le flux d'entrée se termine, la pile est affichée.

La [spécification JFlex](https://westes.github.io/flex/manual/) 
est dans [src/main/jflex/calc.jflex](src/main/jflex/calc.jflex).


## Construction du projet

Pour construire le projet (nécessite l'installation d'une JDK), 
aller dans le dossier du projet puis exécuter 
la commande `./gradelw build` ou `gradelw.bat build`. 

JFlex génère alors, à partir du fichier de spécification [calc.jflex](src/main/jflex/calc.jflex), 
le fichier  `build/generated/sources/jflex/main/java/fr/usmb/compilation/jflex/calc/standalone/Calc.java` 
qui contient l'automate à états finis déterministe correspondant 
à la calculette en [notation postfixée](https://fr.wikipedia.org/wiki/Notation_polonaise_inverse).

Le tout est alors compilé et packagée dans un jar placé dans le dossier `build/libs`. 

Utilisation : `java -jar <chemin du fichier.jar>`

## Importation le projet dans votre IDE favori

Pour importer le projet dans votre IDE favori, 
il suffit de l'importer comme un projet `gradle`.

## Construction image docker

Si vous disposez de docker, un fichier [Dockerfile](Dockerfile) 
permet de construire une image docker et de faire tourner 
la calculette dans un container.

### Construction image : 

```bash
docker build -t stalb/calc:jflex .
```

### Utilisation image : 

```bash
docker run --rm -it stalb/calc:jflex
```