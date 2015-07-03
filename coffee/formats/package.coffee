depInfo = (propertyName) -> """
  <p>The format is <code>"PACKAGE_NAME": "VERSION"</code>, for example:</p>

  <pre><code>"#{ propertyName }": {
    "coffee-script": "1.6.1",
    "gulp": "~3.6.2"
  }</code></pre>

  <p>Packages can be found using the <code>npm search</code> command, or on <a href="http://npmjs.com">npmjs.com</a>.</p>

  <p>Version requirements are specified using <a href="http://ricostacruz.com/cheatsheets/semver.html">semver</a>.</p>
"""

context =
  '': '''
    <h4>package.json</h4>

    <p>All npm packages contain a file, usually in the project root, called package.json - this file holds various metadata relevant to the project. This file is used to give information to npm that allows it to identify the project as well as handle the project’s dependencies. It can also contain other metadata such as a project description, the version of the project in a particular distribution, license information, even configuration data - all of which can be vital to both npm and to the end users of the package. The package.json file is normally located at the root directory of a Node.js project.</p>

    <pre><code>{
      "name": "App",
      "version": "1.3.0",
      "main": "app.js",
      "devDependencies": {
        "dependencyOne": "~1.0.2",
        "dependencyTwo": "~0.0.4"
      }
    }</code></pre>
  '''

  'name': '''
    <h4>Name</h4>

    <p>The name is what your thing is called.</p>

    <p>Some rules:</p>
    <ul>
      <li>The name must be shorter than 214 characters. This includes the scope for scoped packages.
      <li>The name can’t start with a dot or an underscore.
      <li>New packages must not have uppercase letters in the name.
      <li>The name ends up being part of a URL, an argument on the command line, and a folder name. Therefore, the name can’t contain any non-URL-safe characters.
    </ul>

    <p>Some tips:</p>
    <ul>
      <li>Don’t use the same name as a core Node module.
      <li>Don’t put “js” or “node” in the name. It’s assumed that it’s js, since you’re writing a package.json file, and you can specify the engine using the “engines” field.
      <li>The name will probably be passed as an argument to require(), so it should be something short, but also reasonably descriptive.
      <li>You may want to check the <a href="https://npmjs.com">npm registry</a> to see if there’s something by that name already, before you get too attached to it.
    </ul>

    <p>A name can be optionally prefixed by a scope, e.g. <code>@myorg/mypackage</code>.</p>
  '''

  'version': '''
    <h4>Version</h4>

    <p>The version must be a <a href="http://ricostacruz.com/cheatsheets/semver.html">semver</a> version identifier. Changes to the package should come along with changes to the version.</p>
  '''

  'description': '''
    <h4>Description</h4>

    <p>The description should be a string of human-readable information about the package. It’s listed on <a href="https://npmjs.com">npmjs.com</a> and in the output of <code>npm search</code>.</p>
  '''

  'keywords(\.INDEX)?': '''
    <h4>Keywords</h4>

    <p>An array of strings which are used to help people find your package.</p>
  '''

  'homepage': '''
    <h4>Homepage</h4>

    <p>The URL of the project’s homepage, if it has one.</p>
  '''

  'bugs(\.PROPERTY)?': '''
    <h4>Bugs</h4>

    <p>The url to your project’s issue tracker and / or the email address to which issues should be reported. These are helpful for people who encounter issues with your package.</p>

    <p>It should look like this:</p>

    <pre><code>"bugs": {
      "url": "https://github.com/owner/project/issues",
      "email": "project@hostname.com"
    }</code></pre>

    <p>You can specify either one or both values. If you want to provide only a url, you can specify the value for “bugs” as a simple string instead of an object.</p>

    <pre><code>"bugs": "https://github.com/owner/project/issues"</code></pre>

    <p>If a url is provided, it will be used by the <code>npm bugs</code> command.</p>
  '''

  'license': '''
    <h4>License</h4>

    <p>You should specify a license for your package so that people know how they are permitted to use it, and any restrictions you&apos;re placing on it.</p>

    <p>If you&apos;re using a common license such as BSD-2-Clause or MIT, add a current SPDX license identifier for the license you&apos;re using, like this:</p>

    <pre><code>"license": "BSD-3-Clause"</code></pre>

    <p>You can check <a href="https://spdx.org/licenses/">the full list of SPDX license IDs</a>.

    <p>If your package is licensed under multiple common licenses, use an <a href="http://npmjs.com/package/spdx">SPDX license expression syntax version 2.0 string</a>, like this:</p>
    <pre><code>"license": "(ISC OR GPL-3.0)"</code></pre>

    <p>If you are using a license that hasn&apos;t been assigned an SPDX identifier, or if you are using a custom license, use the following valid SPDX expression:</p>
    <pre><code>"license": "SEE LICENSE IN &lt;filename&gt;"</code></pre>

    <p>Then include a file named <code>&lt;filename&gt;</code> at the top level of the package.</p>

    <p>If you do not wish to grant others the right to use a private or unpublished package under any terms:</p>
    <pre><code>"license": "UNLICENSED"</code></pre>
  '''

  '(author|contributors)': '''
    <h4>Author / Contributors</h4>

    <p>Who created and maintains this project? Provide a single person as the <code>author</code> field or an array of multiple people as the <code>contributors</code> field.</p>

    <p>Each person may be described as with object:</p>

    <pre><code>{
      "name": "Barney Rubble",
      "email": "b@rubble.com",
      "url": "http://barnyrubble.tumblr.com/"
    }</code></pre>

    <p>Or a string:</p>

    <pre><code>"Barney Rubble &lt;b@rubble.com&gt; (http://barnyrubble.tumblr.com/)"</code></pre>

    <p>Only name is required, both email and url are optional.</p>
  '''

  'contributors\.INDEX': '''
    <h4>Contributor</h4>

    <p>Each contributor may be described as with object:</p>

    <pre><code>{
      "name": "Barney Rubble",
      "email": "b@rubble.com",
      "url": "http://barnyrubble.tumblr.com/"
    }</code></pre>

    <p>Or a string:</p>

    <pre><code>"Barney Rubble <b@rubble.com> (http://barnyrubble.tumblr.com/)"</code></pre>

    <p>Only name is required, both email and url are optional.</p>
  '''

  'files': '''
    <h4>Files</h4>

    <p>The files field allows you to provide an array of files and folders which should be uploaded to npm when this package is published.</p>

    <p>You may use glob patterns like <code>*.js</code>, and specify folders like <code>src/</code>.</p>

    <p>You can also provide a <code>.npmignore</code> file in the root of your package, which will keep files from being included, even if they would be picked up by the files array.</p>
  '''

  'files\.INDEX': '''
    <h4>File</h4>

    <p>Each file may be specified as the path to a file or folder, or with a glob pattern.</p>

    <p>For example, <code>src/</code>, <code>README.md</code>, or <code>lib/*.js</code>.</p>
  '''

  'main': '''
    <h4>Main</h4>

    <p>The main field informs npm which file should be loaded when a user attempts to <code>require()</code> your package.</p>

    <p>For example, if your package is called <code>app</code> and you specify the main property as <code>"main.js"</code>, when the user runs <code>require('app')</code>, your <code>main.js</code> file will be loaded.</p>
  '''

  'bin(\.PROPERTY)?': '''
    <h4>Bin</h4>

    <p><code>bin</code> allows you to install one or more executable files onto the <code>PATH</code> of this machine so they can be executed from the terminal.</p>

    <p>For example, if you’d like your <code>cli.js</code> file to be executed when the user runs <code>myapp</code> on the command line, you could specify:</p>

    <pre><code>"bin": { "myapp": "./cli.js" }</code></pre>

    <p>If you only have a single executable, and you’d like the command line program to have the same name as your package, you can just specify the file to be executed as a string:</p>

    <pre><code>"bin": "./path/to/program"</code></pre>
  '''

  'man': '''
    <h4>Man</h4>

    <p>The man program is used by many UNIX-y operating systems to help users access documentation. If you have one or more man pages for your project, specify them with the <code>man</code> option.</p>

    <p>The option can either be specified as a single filepath, or as an array of files.</p>
  '''

  'repository(\.PROPERTY)?': '''
    <h4>Repository</h4>

    <p>Specify the place where your code lives.</p>

    <p>For example:</p>

    <pre><code>{
      "type": "git",
      "url": "https://github.com/npm/npm.git"
    }</code></pre>

    <p>The URL should be a publicly available (perhaps read-only) url that can be handed
    directly to a VCS program without any modification. It should not be a url to an
    html project page that you put in your browser. It’s for computers.</p>

    <p>For GitHub, GitHub gist, Bitbucket, or GitLab repositories you can use the same
    shortcut syntax you use for <code>npm install</code>:</p>

    <pre><code>"repository": "npm/npm"
    "repository": "gist:11081aaa281"
    "repository": "bitbucket:example/repo"
    "repository": "gitlab:another/repo"
    </code></pre>
  '''

  'scripts(\.PROPERTY)?': '''
    <h4>Scripts</h4>

    <p>Commands to be executed at various points in the package lifecycle.</p>

    <p>The full list of lifecycle events you can target:</p>

    <ul>
      <li><code>prepublish</code>: Run BEFORE the package is published. (Also run on local npm install without any arguments.)
      <li><code>publish</code>, <code>postpublish</code>: Run AFTER the package is published.
      <li><code>preinstall</code>: Run BEFORE the package is installed
      <li><code>install</code>, <code>postinstall</code>: Run AFTER the package is installed.
      <li><code>preuninstall</code>, <code>uninstall</code>: Run BEFORE the package is uninstalled.
      <li><code>postuninstall</code>: Run AFTER the package is uninstalled.
      <li><code>preversion</code>, <code>version</code>: Run BEFORE bump the package version.
      <li><code>postversion</code>: Run AFTER bump the package version.
      <li><code>pretest</code>, <code>test</code>, <code>posttest</code>: Run by the npm test command.
      <li><code>prestop</code>, <code>stop</code>, <code>poststop</code>: Run by the npm stop command.
      <li><code>prestart</code>, <code>start</code>, <code>poststart</code>: Run by the npm start command.
      <li><code>prerestart</code>, <code>restart</code>, <code>postrestart</code>: Run by the npm restart command. Note: npm restart will run the stop and start scripts if no restart script is provided.
    </ul>

    <p>The command can be any executable:</p>

    <pre><code>"scripts": {
      "prepublish": "rm -r build; gulp build"
    }</code></pre>

    <p>You can also create a script with any name you like, and run it with <code>npm run SCRIPT_NAME</code>.</p>

    <p><a href="https://docs.npmjs.com/misc/scripts">More information</a> about scripts</p>
  '''

  'config(\.PROPERTY)?': '''
    <h4>Config</h4>

    <p>npm supports configuration variables which can be set by the user using <code>npm config</code>. The <code>config</code> option can be used to set defaults for these options.</p>

    <p>Config variables are available as environment variables. For example, if you had the config:</p>

    <pre><code>"config": {
      "port": 8080
    }</code></pre>

    <p>It would be available as the <code>npm_package_config_port</code> environment variable in your scripts, and could be overrode by the user with:</p>

    <pre><code>npm config set foo:port 8001</code></pre>
  '''

  'dependencies': '''
    <h4>Dependencies</h4>

    <p>Dependencies allow you to specify what other npm packages your code requires, and at which versions.</p>
  ''' + depInfo('dependencies')

  'devDependencies': '''
    <h4>Dev Dependencies</h4>

    <p>Dev dependencies work exactly as <code>dependencies</code>, but they are not installed when a user installs your package without downloading the source (unless they provide the <code>--dev</code> option).</p>

    <p>It often makes sense to include build and test tools as dev dependencies, so end users don’t have to install them if their not required to use the package.</p>
  ''' + depInfo('devDependencies')

  'peerDependencies': '''
    <h4>Peer Dependencies</h4>

    <p>If you’re building a plugin which interacts with another package, it’s often valuable to express what versions of that package you support.</p>

    <p>Peer dependencies allow you to express this compatibility. Be as broad as you can, as npm will error if the user tries to use your plugin with an incompatible version.</p>
  ''' + depInfo('peerDependencies')

  'optionalDependencies': '''
    <h4>Optional Dependencies</h4>

    <p>If a package in <code>dependencies</code> fails to install, the installation of your package will be aborted. If you do not wish this to happen for some dependencies (i.e. your package can run without them), include them as optional dependencies.</p>
  ''' + depInfo('optionalDependencies')

  'engines(\.PROPERTY)?': '''
    <h4>Engines</h4>

    <p><code>engines</code> allows you to specify which versions of node or npm this package works with.</p>

    <p>For example:</p>

    <pre><code>"engines": {
      "node": ">=0.10.3 <0.12"
    }</code></pre>
  '''

  '(dependencies|optionalDependencies|peerDependencies|devDependencies)\.PROPERTY': '''
    <h4>Dependency</h4>

    <p>A dependency specifies a package which this project utilizes. It is usually a package which is published to the npm registry, but it can also be anything hosted on the internet or even a local folder.</p>

    <p>When using the npm registry, specify a package name and a version string:</p>

    <pre><code>"vex": "1.4.3"</code></pre>

    <p>The version string should use <a href="http://ricostacruz.com/cheatsheets/semver.html">semver</a>. You can use <code>&lt;</code> and <code>&gt;</code> to specify ranges, for example:

    <pre><code>"vex": ">1.2.3 <2.0.0"</code></pre>

    The <code>~</code> and <code>^</code> shorthands are also available:

    <pre><code>~1.2.3   : is >=1.2.3 <1.3.0

    ^1.2.3   : is >=1.2.3 <2.0.0
    ^0.2.3   : is >=0.2.3 <0.3.0  (0.x.x is special)
    ^0.0.1   : is  =0.0.1         (0.0.x is special)
    </code></pre>

    <p>In the version field you can also specify:</p>

    <ul>
      <li>The URL to a tarball
      <li>The URL to a git repo: <code>git://github.com/user/project.git#commit-ish</code>
      <li>A GitHub repo: <code>visionmedia/mocha#4727d357ea</code>
    </ul>

    <p>As in those examples, it’s usually a good idea to specify a specific commit or tag when using git URLs (by appending the identifier after the “#” symbol).</p>
  '''

  'bundledDependencies(\.INDEX)?': '''
    <h4>Bundled Dependencies</h4>

    <p>Occasionally it’s helpful to include a local copy of a dependency (it’s folder in <code>node_modules/</code>) with the project when it’s published.</p>

    <p>Bundled dependencies are specified as an array of package names, like:</p>

    <pre><code>["gulp", "gulp-concat"]</code></pre>

    <p>Note that another option is to fork the package and refer to it using a git URL.</p>
  '''

  'os(\.INDEX)?': '''
    <h4>OS</h4>

    <p><code>os</code> allows you to specify which operating systems your package will run on.</p>

    <p>You can specify a list of OS’ it works on:</p>

    <pre><code>["darwin", "linux"]</code></pre>

    <p>Or a list it doesn’t work on:</p>

    <pre><code>["!win32"]</code></pre>

    <p>The current host operating system is provided by <code>process.platform</code></p>
  '''

  'cpu(\.INDEX)?': '''
    <h4>CPU</h4>

    <p><code>CPU</code> allows you to specify which processor architectures your package will run on.</p>

    <p>You can specify a list of architectures it works on:</p>

    <pre><code>["x64", "ia32"]</code></pre>

    <p>Or a list it doesn’t work on:</p>

    <pre><code>["!mips"]</code></pre>

    <p>The current architecture is provided by <code>process.arch</code></p>
  '''

  'preferGlobal': '''
    <h4>Prefer Global</h4>

    <p>If your package is primarily a command-line application that should be installed globally, then set this value to <code>true</code> to provide a warning if it is installed locally.</p>
  '''

  'private': '''
    <h4>Private</h4>

    <p>If you set <code>"private": true</code> in your package.json, then npm will refuse to publish it.</p>

    <p>This is a way to prevent accidental publication of private repositories. If you would like to ensure that a given package is only ever published to a specific registry (for example, an internal registry), then use the <code>publishConfig</code> dictionary to specify the registry.</p>
  '''

  'publishConfig': '''
    <h4>Publish Config</h4>

    <p>This is a set of config values that will be used at publish-time. It’s especially handy if you want to set the tag or registry, so that you can ensure that a given package is not tagged with “latest” or published to the global public registry by default.</p>

    <p>See <code>npm help config</code> to see the list of config options that can be overridden.</p>
  '''

  # Browserify
  'browser': '''
    <h4>Browser</h4>
    <p><em><a href="https://github.com/substack/node-browserify">Browserify</a> specific</em></p>

    <p>The <code>browser</code> field allows you to specify browser-specific versions of your files.  Rather than your <code>main</code> file, you might wish to have browserify use a different entry point when this module is bundled for the browser:</p>

    <pre><code>"browser": "./browser.js"<code></pre>

    <p>You can also override multiple files:</p>

    <pre><code>"browser": {
      "fs": "level-fs",
      "./lib/ops.js": "./browser/opts.js"
    }
    </code></pre>
  '''

  'browserify\.transform(\.INDEX)?': '''
    <h4>Transform</h4>
    <p><em><a href="http://browserify.org/">Browserify</a> specific</em></p>

    <p>Transforms are applied to your modules during the Browserify bundling process.  You can use them to do things like <a href="https://www.npmjs.com/package/brfs">include file contents</a> or <a href="https://github.com/jnordberg/coffeeify">compile CoffeeScript</a>.</p>

    <p>For example, to enable the <code>brfs</code> transform:</p>

    <pre><code>"browserify": {"transform": ["brfs"]}</code></pre>

    <p>Be sure to include the necessary module in your <code>dependencies</code> or <code>devDependencies</code> as well.</p>
  '''

  'browserify': '''
    <h4>Browserify</h4>

    <p>The <code>browserify</code> section allows you to provide specific configuration to the <a href="http://browserify.org/">Browserify</a> bundler.</p>

    <pre><code>"browserify": {
      "transform": [
        "coffeeify"
      ]
    },
    </code></pre>
  '''

module.exports = context
