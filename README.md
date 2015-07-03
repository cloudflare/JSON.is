# JSON.is

Open-source documentation for common JSON formats.

Currently included:

- [bower.json.is](http://bower.json.is) — `bower.json` documentation
- [install.json.is](http://install.json.is) — `install.json` documentation
- [package.json.is](http://package.json.is) — `package.json` documentation

## Contributing

We welcome contributors of both improvements and additional JSON formats.

### Format

Format definition files are located in [coffee/formats](https://github.com/EagerIO/JSON.is/tree/master/coffee/formats).

The definitions are [CoffeeScript](http://coffeescript.org/) source files.  Each file exports an
object mapping [regular expressions](http://www.cheatography.com/davechild/cheat-sheets/regular-expressions/)
to HTML descriptions.  The regular expressions are tested against the path to the object the user
currently has his or her cursor over.  The first complete match determines what documentation block
is shown.

For example, to add a doc for `{"engines": ...}`, you would specify:

```coffeescript
'engines': '''
  <h4>Engines</h4>
'''
```

Any character with special meaning in regular expressions (like `[` and `.`) should be escaped with a backslash:

```coffeescript
'engines\.node': '''
  <h4>Node Version</h4>
'''
```

There are two 'shortcuts' which are available, `INDEX` and `PROPERTY`.

- `INDEX` (`\d+`) matches any index within an array
- `PROPERTY` (`[^\.]+`) matches any key within an object

For example, to write a doc for any property within `engines`:

```coffeescript
'engines\.PROPERTY': '''
  <h4>Engines</h4>
'''
```

You can use regular expression syntax to create a section which will match both the parent, and it's children:

```coffeescript
'engines(\.PROPERTY)?': '''
  <h4>Engines</h4>
'''
```

When dealing with an array, you can do a similar thing with `INDEX`:

```coffeescript
'keywords\.INDEX': '''
  <h4>Keyword</h4>
'''
```

You can use the pipe regular expression syntax to match multiple options:

```coffeescript
'(dependencies|devDependencies)': '''
  <h4>Dependencies</h4>
'''
```

As each file is CoffeeScript, you can add arbitrary code:

```coffeescript
'description': '''
  <h4>Description</h4>
''' + new Date
```

Each doc body can also be a function, which will be passed the item which was matched:

```coffeescript
'(dependencies|devDependencies)': (item) ->
  "<h4>#{ item.path }</h4>"
```

#### HTML Conventions

- Begin each doc with a title in an `h4`.
- Wrap each paragraph in a `p`.
- Docs can optionally begin with a subtitle wrapped like `<p><em>Subtitle</em></p>`
- Inline code blocks should be wrapped with a `code` element
- Block code blocks should be wrapped like `<pre><code>my code</code></pre>`
