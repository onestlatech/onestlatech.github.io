# Contribuer

## Contribuer au site

1. Installer [Hugo](https://gohugo.io/)
2. `hugo serve`

## Importer les signatures

1. [Créer un *fine-grained token* GitHub](https://github.com/settings/personal-access-tokens/new) pour le dépôt `onestlatech/onestlatech.github.io` avec la permission `Issues: Read and Write`
2. `bundle install`
3. `GITHUB_TOKEN=<le-token> ruby list.rb`
4. Commiter et pousser
