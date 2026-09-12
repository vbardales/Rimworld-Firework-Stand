---
mod:        Firework Stand
packageId:  nelim.fireworkstand
depot:      Rimworld-Firework-Stand
visibilite: public
detache:    oui
etape:      preTest
licence:    alive
licence_ou: Fireworks ne livre aucun fichier de licence, et telardo est vivant ; rien de lui n'est redistribue ici
vitrine:    complete
teste_le:
workshop:   
reste:
  - non_verifie: jamais vu tourner en jeu ; TESTING.md pose 9 scenarios, dont 5 bloquent la publication
  - non_verifie: cinq des 25 tests hors jeu portent sur Assembly-CSharp lui-meme et n'ont pas pu etre vus rouges ; ce sont ceux du crochet du driver et du veto de lumiere, les plus importants
  - defaut: la ligne d'inspection dit "Ready to fire" meme sur une rampe vide, parce qu'elle rend l'intervalle et non le carburant ; la jauge dit le vrai a cote
  - defaut: le ModIcon est la frimousse orange, qui ne represente pas le batiment et se lit mal a 32 px ; ecart accepte le 2026-09-04, ne pas rouvrir
session:    local_db219fa5-6fea-40f2-b0fa-aa63c79d3774
maj:        2026-09-12, session du mod
---

# Firework Stand — etat

Fiche d'etat, lue par une passe sur tous les mods plutot qu'en interrogeant les fils un a un.
Elle vit a la racine, jamais dans `Mod/`, donc Steam ne la recoit pas.

Les champs ci-dessus ont ete deduits du disque le 2026-09-12 par cette passe, puis repris le meme
jour par la session qui tient ce mod. Deux de ses deductions etaient fausses :

- **`etape`** — `preTest` et non `done`. Le contenu, les images, la documentation et le jeu de
  tests hors jeu sont faits, mais le `CHANGELOG` porte toujours `[Unreleased]` et rien n'a jamais
  ete publie. Il ne reste que l'essai en jeu, et c'est lui qui separe les deux valeurs.
- **`licence`** — `alive` et non `silent`. La passe avait raison sur le fait, Fireworks ne livre
  aucun fichier de licence, et tort sur ce qu'il implique : `silent` suppose une source morte,
  alors que telardo tient toujours son mod, mis a jour pour 1.6. La nuance compte, parce qu'une
  source vivante peut etre contactee.
- **`teste_le`** — vide, et exact. Personne n'a jamais vu ce mod tourner. Le `packageId` n'est
  dans aucun `ModsConfig.xml`.
- **`workshop`** — vide, et exact. Pas de `PublishedFileId.txt` dans `Mod/`, donc rien n'a jamais
  ete televerse. La vitrine est prete pour autant.
- **`reste`** — la ligne posee d'office est remplacee par quatre, deux inconnues et deux defauts
  connus.

Vocabulaire de `licence` : `open` licence explicite, `silent` aucune licence et source morte,
`alive` aucune licence mais source vivante, `forbidden` refus ecrit, `original` rien de repris.

## Ce que veut dire `alive` ici

Ce mod n'etend pas une source morte, il etend un mod vivant dont il se declare dependant et dans
lequel il appelle a l'execution. Rien de telardo n'est recopie : ni texture, ni son, ni fichier de
def. Le batiment se dessine avec sa propre texture `Things/Item/FireworkLauncher`, chargee depuis
son dossier a lui. Une seule chose est reproduite plutot qu'appelee, parce que sa methode est
privee, le tirage des souvenirs d'humeur, et `ATTRIBUTION.md` le dit ligne par ligne.

La consequence pratique : si telardo prefere que ce mod n'existe pas sous cette forme, il suffit
qu'il le dise. C'est ecrit dans `ATTRIBUTION.md`.

## Ce qui reste, en clair

L'essai en jeu, et rien d'autre cote developpement. `TESTING.md` le decoupe en neuf scenarios et
dit lesquels bloquent la publication. Les deux qui comptent sont le **3**, le rearmement, qui est
le seul mecanisme sur lequel tout le mod repose, et le **4**, le veto du lueur, dont l'echec donne
une rampe chargee allumee en permanence comme une lampe.

L'autre moitie du test ne demande pas de colonie et tourne en quinze secondes :

```
powershell -NoProfile -ExecutionPolicy Bypass -File _tools/Run-Functional-Tests.ps1
```

Elle a deja trouve un defaut reel, `showFuelGizmo` qui n'a plus de lecteur en 1.6. Mais cinq de
ses 25 tests portent sur `Assembly-CSharp` lui-meme et n'ont pas pu etre vus rouges, faute de
pouvoir muter le jeu : ce sont justement ceux du crochet du driver et du veto de lumiere. D'ou la
deuxieme ligne de `reste`, que seul un essai en jeu fera tomber.

Attention en le jouant : le batiment est **absent du menu Architecte** tant que `IEDs` n'est pas
recherche, et non grise. Une colonie neuve donne donc l'impression d'un mod casse.

## Comment cette fiche se tient a jour

Apres tout changement du mod, relire les champs, et trois d'entre eux surtout :

- `etape` passe a `done` le jour ou le mod sort, pas avant.
- `teste_le` prend la date du jour ou un essai en jeu s'est bien passe, avec ce qui a ete verifie
  dit dans `reste` si l'essai etait partiel.
- `reste` perd sa ligne des qu'elle cesse d'etre vraie, et n'en gagne une que pour quelque chose
  qu'on saurait nommer a quelqu'un d'autre.

Le reste se deduit du disque et la passe automatique le refera. `session` est sa comptabilite a
elle : cette fiche ne le touche pas.
