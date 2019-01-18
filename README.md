# forte_presenter_plugin
A plugin for [presenters](http://github.com/rx/presenters) to manage frontend Forte and Forte.js functions

## Demo
1. Fork or clone [http://github.com/rx/presenters](http://github.com/rx/presenters)
2. `cd presenters` (project root)
3. Add `gem 'forte_presenter_plugin'` to its Gemfile.
4. `bundle install`
5. Copy this repo's `/demo/forte.pom` into presenters' `/app/plugins/` directory.
6. In `/app/plugins/forte.pom`, use your Forte API Login ID for the `set_forte_api_login_id` call (use a sandbox ID). 
7. `rackup`
8. `open http://localhost:9292/plugins/forte`




