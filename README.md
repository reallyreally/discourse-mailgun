# Mailgun plugin for Discourse

Provides a simple endpoint for Mailgun to deliver inbound emails to Discourse

## Getting Started

You should install the plugin via the current Discourse plugin instructions - https://meta.discourse.org/t/install-a-plugin/19157

### Prerequisites

You will require a Mailgun account, enabled domain and incoming mail enabled.
Follow the instructions in the [Mailgun](http://mailgun-documentation.readthedocs.io/en/latest/quickstart-receiving.html#how-to-start-receiving-inbound-email) docs
Create a rule to forward email to this plugin

```
match_recipient(“reply-.*@mydiscourse.domain”)
forward(“https://mydiscourse.domain/mailgun/incoming”)
```

### Installing

Installing this plugin should be as simple as following the [Discourse Plugin installation tutorial](https://meta.discourse.org/t/install-a-plugin/19157)

## Running the tests

In order to run tests you'll need a Discourse development environment such as the [vagrant](https://github.com/discourse/discourse/blob/master/docs/VAGRANT.md) one.

You can then run the tests with `rake plugin:spec[discourse-mailgun]`

## Deployment

Once the plugin is installed, you'll need to configure a few things:

* Mailgun API key - which you can retrieve in your mailgun settings
* Discourse Base URL - the URL where your discourse is available
* Discourse API key - you can create one in the discourse admin panel
* Discourse API username

You can do this in the plugin settings page.

You'll also need to enable "manual polling enabled" in your discourse email settings admin panel.

## Built With

* [Atom](https://atom.io) - The editor used
* [Ruby on Rails](http://rubyonrails.org) - Application framework
* [Discourse Plugins](https://meta.discourse.org/t/beginners-guide-to-creating-discourse-plugins-part-1/30515) - Plugin framework for Discourse

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/reallyreally/discourse-mailgun/tags). 

## Authors

* **Tiago Macedo** - *Initial work* - [Really Really Inc](https://really.ai/)

See also the list of [contributors](https://github.com/reallyreally/discourse-mailgun/contributors) who participated in this project.

## License

This project is licensed under the Apache 2.0 - see the [LICENSE.md](LICENSE.md) file for details
