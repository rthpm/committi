# README

# Présentation

En me baladant sur GitHub, je me suis dit que j’aimerais trop avoir quelque chose comme la heatmap mais étendu à d’autres domaines. Alors je me suis penché sur l’idée d’une application pour traquer mes autres habitudes, me motiver à en créer de nouvelles et puis pourquoi pas rendre la chose communautaire pour pimenter la chose !

En couchant tout ça sur le papier, j’ai eu l’idée d'une application ou un utilisateur pouvait créer un défi et fixer la régularité ou l’on devait traquer son progrès : journalier, hebdomadaire ou mensuel, arbitraire (en nombre de jours). Les défis peuvent être divers et variés ! Le mois sans tabac, un club de lecture, l’apprentissage d’une langue, etc. Avant la fin de l’échéance en cours, les utilisateurs inscrits au défi devront poster un status sous le défi avec leur retour : "ah, c’était dur aujourd’hui, j’ai failli craquer..." pour le mois sans tabac par exemple, ou "J’ai enfin fini Twilight, je vais pouvoir passer à autre chose" pour le club de lecture. Ces status peuvent eux même contenir des commentaires des autres utilisateurs : "Perso je mets un crayon dans ma bouche quand j’ai trop envie" pour le status du mois sans tabac, ou "Comment ça passer à autre chose ? Il y a les films maintenant !" pour le status du club de lecture. On pourrait aussi liker les status !

La killer feature est la progression : si on ne respecte pas une échéance, la progression d’un utilisateur sur un défi donné tombe à zéro ! Dans le cas contraire, on incrémente sa progression d’un jour.

Évidemment, tout cela se fait sur la base de la bonne foi, il n’y a aucunement besoin de poster une preuve concrète de sa participation, mais les utilisateurs ayant les droits admin (le créateur) ou modérateur sur un défi pourront supprimer des status ou des commentaires déplacés.



Voici le lien du heroku:  http://committi.herokuapp.com

Voici le GEMFILE: 

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.4'

gem 'rails', '~> 5.2.6'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'devise'
gem 'devise-i18n'
gem 'strong_password', '~> 0.0.9'
gem 'aws-sdk-s3', '~> 1' # We use Backblaze’s S3 API
gem 'stripe'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'better_errors'
  gem 'binding_of_caller' # Better errors dependency
  gem 'table_print'
  gem 'rubocop', '0.81', require: false
  gem 'rubocop-rails', require: false
  gem 'letter_opener'
  gem 'faker'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

