context =
  '': '''
    <h4>bower.json</h4>

    <p>Web sites are made of lots of things — frameworks, libraries, assets, utilities, and rainbows. <a href="http://bower.io/">Bower</a> manages all these things for you.</p>

    <p>Bower works by fetching and installing packages from all over, taking care of hunting, finding, downloading, and saving the stuff you’re looking for. Bower keeps track of these packages in a manifest file, bower.json. How you use packages is up to you. Bower provides hooks to facilitate using packages in your tools and workflows.</p>

    <p>Bower is optimized for the front-end. Bower uses a flat dependency tree, requiring only one version for each package, reducing page load to a minimum.</p>
  '''

  'name': '''
    <h4>Name</h4>

    <p>The name of the package as stored in the registry.</p>

    <ul>
      <li>Must be unique.</li>
      <li>Should be slug style for simplicity, consistency and compatibility. Example: <code>unicorn-cake</code></li>
      <li>Lowercase, a-z, can contain digits, 0-9, can contain dash or dot but not start/end with them.</li>
      <li>Consecutive dashes or dots not allowed.</li>
      <li>50 characters or less.</li>
    </ul>
  '''

  'main': '''
    <h4>Main</h4>

    <p><em>Recommended</em><br>Type: <code>String</code> or <code>Array</code> of <code>String</code></p>

    <p>The entry-point files necessary to use your package. Only one file per filetype.</p>

    <p>Entry-point files have module exports and may use module imports. While Bower does not directly use <code>main</code> files, they are listed with the commands <code>bower list --json</code> and <code>bower list --paths</code>, so they can be used by build tools.</p>

    <p>Let's say your package looks like this:</p>

    <pre><code>package
      js/
        motion.js
        run.js
        walk.js
      sass/
        motion.scss
        run.scss
        walk.scss
      img/
        motion.png
        walk.png
        run.png
      fonts/
        icons.woff2
        icons.woff
      dist/
        movement.js
        movement.min.js
        movement.css
        movement.min.css
    </code></pre>

    <p><code>motion.js</code> has module imports for <code>run.js</code> and <code>walk.js</code>. <code>motion.scss</code> has module imports for <code>run.scss</code> and <code>walk.scss</code>. <code>main</code> would be</p>

    <pre><code>"main": [
      "js/motion.js",
      "sass/motion.scss",
    ]
    </code></pre>

    <p>Image and font files may be used or referenced within the JS or Sass files, but are not <code>main</code> files as they are not entry-points.</p>

    <ul>
      <li>Use source files with module exports and imports over pre-built distribution files.</li>
      <li>Do not include minified files.</li>
      <li>Filenames should not be versioned (Bad: <code>package.1.1.0.js</code>; Good: <code>package.js</code>).</li>
      <li>Globs like <code>js/*.js</code> are not allowed.</li>
    </ul>
  '''

  'description': '''
    <h4>Description</h4>

    <p>Help users identify and search for your package with a brief description. Describe what your package does, rather than what it’s made of. Will be displayed in search/lookup results on the CLI and the website that can be used to search for packages.</p>

    <p>Can contain any characters, but should be 140 characters or less.</p>
  '''

  'version': '''
    <h4>Version</h4>

    <p>Ignored by Bower as <a href="http://ricostacruz.com/cheatsheets/semver.html">semver</a> <a href="https://git-scm.com/book/en/v2/Git-Basics-Tagging">git tags</a> are used instead.</p>

    <p><em>Intended to be used in the future when Bower gets a real registry where you can publish actual packages, but for now just leave it out.</em></p>
  '''

  'authors(\.INDEX)?': '''
    <h4>Authors</h4>

    <p>A list of people that authored the contents of the package.</p>

    <p>Any of these formats are acceptable:</p>
    <ul>
      <li><code>John Doe</code>
      <li><code>John Doe &lt;john@doe.com&gt;</code>
      <li><code>John Doe &lt;john@doe.com&gt; (johndoe.com)</code>
    </ul>
  '''

  'licence': '''
    <h4>License</h4>

    <p><a href="https://spdx.org/licenses/">SPDX license identifier</a> or path/url to a license.</p>
  '''

  'ignore(\.INDEX)?': '''
    <h4>Ignore</h4>

    <p>An array of file and folder paths for Bower to ignore when installing your package.  Glob patterns like <code>*.js</code> may be used.</p>
  '''

  'devDependencies': '''
    <h4>Dev Dependencies</h4>

    <p>Dependencies that are only needed for development of the package, e.g., test framework or building documentation.</p>
  '''

  'dependencies': '''
    <h4>Dependencies</h4>

    <p>Dependencies are specified with a simple hash of package name to a <a href="http://ricostacruz.com/cheatsheets/semver.html">semver</a> compatible identifier or URL.</p>

    <ul>
      <li>Key must be a valid name.</li>
      <li>Value must be a valid version, a Git URL, or a URL (inc. tarball and zipball).</li>
      <li>Git URLs can be restricted to a reference (revision SHA, branch, or tag) by appending it after a hash, e.g. <code class="inline">https://github.com/owner/package.git#branch</code>.</li>
      <li>Value can be an owner/package shorthand, i.e. owner/package. By default, the shorthand resolves to GitHub -&gt; git://github.com/{{owner}}/{{package}}.git. This may be changed in <code>.bowerrc</code> <a href="http://bower.io/docs/config/#shorthand-resolver">shorthand_resolver</a>.</li>
      <li>Local paths may be used as values for local development, but they will be disallowed when registering.</li>
    </ul>
  '''

  '(dependencies|devDependencies)\.PROPERTY': '''
    <h4>Dependency</h4>

    <p>Each dependency is specified with its name, and either a <a href="http://ricostacruz.com/cheatsheets/semver.html">semver</a> compatible version or URL.</p>

    <ul>
      <li>Key must be a valid project name.</li>
      <li>Value must be a valid version, a Git URL, or a URL (inc. tarball and zipball).</li>
      <li>Git URLs can be restricted to a reference (revision SHA, branch, or tag) by appending it after a hash, e.g. <code>https://github.com/owner/package.git#branch</code>.</li>
      <li>Value can be an owner/package shorthand, i.e. owner/package. By default, the shorthand resolves to GitHub -&gt; git://github.com/{{owner}}/{{package}}.git. This may be changed in <code>.bowerrc</code> <a href="http://bower.io/docs/config/#shorthand-resolver">shorthand_resolver</a>.</li>
      <li>Local paths may be used as values for local development, but they will be disallowed when registering.</li>
    </ul>
  '''

  'homepage': '''
    <h4>Homepage</h4>

    <p>URL to learn more about the package. Falls back to GitHub project if not specified and it’s a GitHub endpoint.</p>
  '''

  'resolutions(\.PROPERTY)?': '''
    <h4>Resolutions</h4>

    <p>Dependency versions to use if conflicts occur between packages.  Usually added by the bower tool when versions are manually resolved by the user.</p>
  '''

  'private': '''
    <h4>Private</h4>

    <p>Set to <code>true</code> if you do not wish this project to ever be published publicly.
  '''

module.exports = context
