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
forward(“https://mydiscourse.domain/admin/plugin/mailgun”)
```

### Installing

A step by step series of examples that tell you have to get a development env running

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Atom](https://atom.io) - The editor used
* [Ruby on Rails](http://rubyonrails.org) - Application framework
* [Discourse Plugins](https://meta.discourse.org/t/beginners-guide-to-creating-discourse-plugins-part-1/30515) - Plugin framework for Discourse

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Author Name** - *Initial work* - [Company](https://really.ai/)

See also the list of [contributors](https://github.com/reallyreally/discourse-mailgun/contributors) who participated in this project.

## License

This project is licensed under the Apache 2.0 - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone who's code was used
* Inspiration
* etc
