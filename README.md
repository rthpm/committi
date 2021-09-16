# Committi

Turn your ambition into community challenge!

Committi is a social network that aims to help people tackling challenges and
goals with a community twist. Want to write 200 words a day? Why would you keep
that goal to yourself? Have fun together!

Visit the homepage for more information: https://committi.herokuapp.com


## Initial setup

Use the steps below for a local install.

- Install the ruby version specified in `.ruby-version`.
- Checkout the `front` branch from the repository:
    ```sh
    ; git clone https://github.com/rthpm/committi
    ; cd committi
    ```
- Run bundler to install the gems needed for the project:
    ```sh
    ; bundle
    ```
- Install `mailcatcher` to intercept outgoing emails in a development
    environment:
    ```sh
    ; gem install mailcatcher
    ; mailcatcher # mailcatcher will run in the background
    ```
- Create the databases, run the migration, and give the seed some work:
    - You need a working `postgresql` installation
    ```sh
    ; rails db:create db:migrate db:seed
    ```
- Categories creation never involves the user. So we decided to generate them
    “manually” from a script, or from the console, if you have more urgent
    needs.
    ```sh
    ; rails r lib/tasks/create_categories.rb
    ```
- Launch the application:
    ```sh
    ; rails s
    ```
