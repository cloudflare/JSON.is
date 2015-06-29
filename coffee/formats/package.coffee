context =
  'default': '''
    <h4>package.json</h4>

    <p>All npm packages contain a file, usually in the project root, called package.json - this file holds various metadata relevant to the project. This file is used to give information to npm that allows it to identify the project as well as handle the project's dependencies. It can also contain other metadata such as a project description, the version of the project in a particular distribution, license information, even configuration data - all of which can be vital to both npm and to the end users of the package. The package.json file is normally located at the root directory of a Node.js project.</p>

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

module.exports = context
