# devise\_signin\_loggable

Every time a user signs in, log the time and IP.

## Installation

Add this to your Gemfile:

    gem 'devise_signin_loggable'

And run:

    $ bundle

Or install it with:

    $ gem install devise_signin_loggable


## Usage

After installation, run in the install generator and migrations:

    rails generate devise_signin_loggable:install
    rake db:migrate

In the user models for which you want to log signins, add `:signin_loggable` to
the list of included devise modules:

    devise :signin_loggable

## Configuration

Since a table of every signin by every user can obviously grow quickly, there
are two options to clear out old data: either by limiting the number of signins
stored per user, or by only keeping signins less than a given age.

In `devise.rb`, the generator adds the following lines:

    # config.max_logged_signins_per_user = 50
    # config.remove_logged_signins_older_than = 3.months

Uncomment and edit the values to suit. You can enable both options, but a given
log need only meet *one* of the conditions to be deleted.

## Author

Aaron Klaassen  
aaron@outerspacehero.com  
http://www.outerspacehero.com/  
[@aaronklaassen](https://www.twitter.com/aaronklaassen/)
