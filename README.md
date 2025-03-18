Triple Baked Core
=================
A flexible CMS system for Rails 8, the next iteration of TwiceBaked -> https://bitbucket.org/moser-inc/tb_core

Using in your app
=================

In your Gemfile:
`gem 'triple_baked_core', git: 'https://github.com/moser-inc/triple_baked_core`

**TODO - copy over instructions from tb_core 1.5 as features get transitioned over** 

Developing
==========

## Test setup

1. Look at `.env.EXAMPLE` to see the environment variables you need to set up your Postgres database. Make `.env` file with those vars.
2. Set up your test database with `RAILS_ENV=test rake db:setup` 
3. `rake app:spec`


## Developing the frontend

When first using this project, you should run `yarn install` to download the JS dependencies. The admin frontend uses
the Bootstrap CSS system, imported from `node_modules`. Also, the Hotwire framework components Turbo and Stimulus 
(https://hotwired.dev).

While you're developing, it' recommended to run the JS/CSS dependency build script `./build.js` in a separate process
(like through a terminal window or process managed by your IDE). The best way to run it through NPM: `npm run watch`
This script will monitor the contents of the `app/javascript` directory for changes, bundle them, and drop the outputs
in the `app/assets/builds` folder.

When TripleBaked is included in another Rails application as a gem, the Rails asset pipeline (Sprockets or Propshaft)
should be able to find the 

### Assets in Production

Note that because this is a gem, `assets/builds/*` gets committed to the repo! In your parent app, if you are using
Propshaft with `jsbundling-rails`, the `assets/builds/*` should not be committed because it won't get used in 
production. In production, the `rake assets:precompile` stage will take the contents of your app's assets, and
the assets here in `app/assets/builds/triple_baked_core/*`, and put them in the public/assets folder with
version hashes appended to the file names. The public/assets folder should be served by your production web server. 


# License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
