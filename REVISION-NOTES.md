Révision rédactionnelle et vérification du rapport — 8 septembre 2026

Le texte a été revu pour un lecteur de rapport universitaire : phrases plus directes, termes expliqués à leur première utilisation, conclusions centrées sur les résultats et suppression des commentaires qui justifiaient la rédaction elle-même. Ces choix suivent les recommandations de [Digital.gov sur la clarté de l'écriture](https://digital.gov/guides/plain-language/writing). Ils ne reposent pas sur un détecteur de texte généré.

Les cinq chapitres, les résumés français et anglais, l'introduction et la conclusion ont été révisés. Les données personnelles de la couverture et les remerciements ont été conservés comme informations de l'auteur; cette révision ne les authentifie pas.

Corrections et décisions documentées :

- L'introduction annonce désormais cinq chapitres, avec le chapitre de résultats.
- Le calendrier de cinq semaines a été retiré : aucune feuille de temps ou chronologie validée n'a été identifiée pour étayer ces durées. La description des phases est conservée. La capture de comparaison des modèles apparaît une seule fois, au chapitre des résultats.
- Les titres et acteurs des descriptions de cas d'utilisation sont en français; les identifiants UC et les diagrammes restent conservés. Le renvoi à une description textuelle UC-01 absente a été remplacé par BF-01.
- Les 5 202 doublons sont décrits comme des lignes excédentaires à caractéristiques identiques. Le nettoyage retire 128 lignes conflictuelles, puis 5 080 copies supplémentaires, et conserve 117 909 observations.
- Les tableaux précisent qu'ils rapportent la macro-F1, les moyennes de validation sur trois graines et le test de la graine 42. Les FPR binaire et multiclasse sont distingués. Les trois partitions aléatoires ne sont pas présentées comme des collectes indépendantes.
- La latence de 19,27 / 31,79 ms est la moyenne de trois p95 d'inférence unitaire sur les premières 1 000 lignes de validation. Elle exclut HTTP et la base. La convention du Brier et le calcul de l'ECE sont explicités.
- Le champ `code_worktree_dirty=true` du rapport d'entraînement est maintenant signalé : le commit enregistré ne suffit pas à reconstituer le code exact. Le relevé matériel ne donne pas le processeur ni la mémoire. Aucune configuration n'a été déduite de la machine actuelle.
- La mention de Neovim a été retirée de l'environnement documenté, faute de trace dans le relevé d'exécution consulté. Les versions Python, Node.js et le système proviennent de ce relevé.

Sources externes consultées :

| Source | Utilisation et limite |
| --- | --- |
| [Notice UCI RT-IoT2022](https://archive.ics.uci.edu/dataset/942/rt-iot2022) | Confirme 123 117 observations, 83 variables et l'attribution de l'extraction à Zeek/Flowmeter. Les étiquettes et effectifs du rapport viennent du fichier local audité; la liste descriptive UCI comporte des différences. |
| [Cantone, Marrocco et Bria, version auteur](https://arxiv.org/abs/2402.10974) | Étude du transfert entre quatre jeux de données : soutient la prudence sur la généralisation, sans mesurer RT-IoT2022. |
| [API NFStream](https://www.nfstream.org/docs/api) | Documente les temporisations et modes de comptage qui influencent les variables. L'absence d'équivalence démontrée avec RT-IoT2022 est une conclusion du projet, pas une déclaration de NFStream. |
| [NIST SP 800-94](https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-94.pdf) | Référence pour les signatures, les anomalies et l'observation passive; aucune certification du prototype n'en est déduite. |
| [NIST IR 8349](https://www.nist.gov/publications/methodology-characterizing-network-behavior-internet-things-devices) | Méthode de capture du comportement réseau IoT, utilisée comme référence de collecte. |
| [Lundberg et Lee, SHAP](https://proceedings.neurips.cc/paper_files/paper/2017/hash/8a20a8621978632d76c43dfd28b67767-Abstract.html) | Attribution des contributions à une prédiction; la citation a été ajoutée au passage sur les explications. |
| [Calibration scikit-learn](https://scikit-learn.org/stable/modules/calibration.html) | Cadre de lecture des probabilités calibrées; les chiffres et conventions exactes sont vérifiés dans le code local. |

Vérifications locales :

- `models/production/manifest.json` : empreintes du rapport, de la référence de dérive, des deux modèles et de leurs métadonnées vérifiées.
- `models/production/evaluation-report.json` : chiffres des comparaisons, du nettoyage, de la cascade, des classes rares, de la calibration et de la taille des modèles contrôlés.
- `machine-learning/src/iot_ids_ml/{training,evaluation}.py` : règle de sélection, écart-type, Brier, ECE et protocole de latence relus.
- `backend/app/database/models.py` et services d'ingestion : relations persistantes et transactions examinées.
- `machine-learning/reports/generated/presentation-evidence.json` et journaux associés : trois groupes au statut `pass`, dix parcours navigateur et trois scénarios Suricata pour l'exécution du 7 septembre 2026. Cette révision n'a pas relancé ces tests applicatifs.

La bibliographie existante a été conservée, avec deux références documentaires ajoutées. Cette vérification ciblée ne constitue pas une revue exhaustive de chaque publication citée. Les performances externes, les durées personnelles de travail et une configuration matérielle précise restent non établies.

Le PDF a été recompilé avec `latexmk -pdf -interaction=nonstopmode -halt-on-error -cd src/main.tex`. Les citations et renvois sont résolus. Les 18 lignes des tableaux numériques ont été comparées automatiquement au JSON; l’empreinte du CSV source a aussi été vérifiée. Les pages de résultats ont été contrôlées visuellement. Les avertissements restants concernent un dépassement de 0,62 pt sur la couverture, deux ancres de légende et l’espacement d’une URL bibliographique.
