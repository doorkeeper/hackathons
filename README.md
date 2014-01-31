# Hackathons!

[Hackathons!](http://www.hackathons.jp/) is a site that lists hackathons happening in Japan.

To add your hackathon to the listing, create a pull request with a YAML file in the `data/events` directory.

See [data/events/tbs-tv-hack-day.yaml](data/events/tbs-tv-hack-day.yaml) for an example of the format.

## Developing Hackathons!

Hackathons is a static html site generated using [middleman](http://middlemanapp.com/). You can set it up locally with the following:

```
git clone git@github.com:doorkeeper/hackathons.git
cd hackathons
bundle install
bundle exec middleman server
```

## License

Hackathons! is licensed under the [CC BY license](http://creativecommons.org/licenses/by/4.0/).
