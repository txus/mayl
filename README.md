# mayl - a YAML console

Mayl is an anagram of YAML, and also a console to create, edit and maintain
YAML files in any kind of Ruby projects.

## Warning: Not released yet

This is not a released project yet. It's just a Readme specification to define
the API and some features. You'll see a usable version soon! ;)

## Installation

Install mayl yourself:

    $ gem install mayl

## Usage

Mayl expects your YAML files to be organized like this: one file per locale
(`en.yml`, `es.yml`, `ca.yml`...) in a directory.

When it starts, it needs to know where to find all these YAML files, and it
looks by default under `./config/locales` but you can always run it like `mayl
some/other/dir` to override this.

    $ mayl
    Detected locales: ca, en, es
    >

Now we'll set a new key by typing `set KEY` and typing in the translations:

    > set activerecord.models.post
      ca: Article
      en: Post
      es: Artículo

      Set activerecord.models.post to Article (ca), Post (en) and Artículo (es)
    >

Changes get written to the file immediately. We can consult a key any time,
and in case we see any error, correct it quickly with `edit LOCALE NEWVALUE`:

    > get activerecord.models.post
      ca: Article
      en: Post
      es: Artículo
    > edit es Entrada

      Set activerecord.models.post to Entrada (es)
    >

### Namespaces

If you want to work for a while inside a namespace, let's say
`activerecord.models`, you can do so by `cd`-ing into it, and even `ls` the
existing keys:

    > cd activerecord.models
    activerecord.models > get post
      ca: Article
      en: Post
      es: Entrada
    activerecord.models > cd ..
    activerecord > ls
    models attributes
    activerecord > cd ..
    >

Cool way to navigate your YAML files huh?

### Other useful commands

* `reload`: Reloads the file in case someone has changed it for some reason
  (which ideally should not happen).
* `exit`: Exits the console.

## Development

To run the tests:

    $ rake

To build the documentation under the `doc` directory:

    $ rake doc

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Who's this

This was made by [Josep M. Bach (Txus)](http://txustice.me) under the MIT
license. I'm [@txustice](http://twitter.com/txustice) on twitter (where you
should probably follow me!).
