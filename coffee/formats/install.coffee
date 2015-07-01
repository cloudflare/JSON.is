context =
  'default': '''
    <h4>install.json</h4>

    <p>install.json is a description of how to include and configure (JavaScript, CSS, and HTML)-based projects into websites.</p>

    <p>install.json has two top-level properties, <code>resources</code> and <code>options</code>. Essentially resources are files included into the page and options are configurations for them.</p>

    <p>Here’s a simple example of an install.json file which includes one JS file and has one color option:</p>

    <pre><code>{
      "resources": {
        "head": [
          {
            "type": "script",
            "src": "./file.js"
          }
        ]
      },
      "options": {
        "properties": {
          "color": {
            "title": "Color",
            "type": "string",
            "format": "color",
            "default": "#e90f92"
          }
        }
      }
    }</code></pre>
  '''

  'resources': '''
    <h4>Resources</h4>

    <p>The JavaScript and CSS files you want to be included in the page.</p>
    <p>Each resource can be placed in either the <code>&lt;head&gt;</code> or <code>&lt;body&gt;</code> of the page by placing it in in the respective key’s array.</p>

    <pre><code>"resources": {
      "head": [
        {
          "type": "script",
          "src": "./file.js"
        }
      ],
      "body": [
        {
          "type": "style",
          "src": "./file.css"
        }
      ]
    }</code></pre>
  '''

  'resources\.head(\.INDEX)?': '''
    <h4>Head Resources</h4>

    <p>The JavaScript and CSS files you want to be included in the <code>&lt;head&gt;</code> of the page.</p>

    <pre><code>"head": [
      {
        "type": "script",
        "src": "./file.js"
      }
    ]</code></pre>
  '''

  'resources\.body(\.INDEX)?': '''
    <h4>Body Resources</h4>

    <p>The JavaScript and CSS files you want to be included in the <code>&lt;body&gt;</code> of the page.</p>

    <pre><code>"body": [
      {
        "type": "script",
        "src": "./file.js"
      }
    ]</code></pre>
  '''

  'resources\.(head|body)\.INDEX\.type': '''
    <h4>Resource Type</h4>

    <p>For JavaScript files, use:</p>
    <pre><code>"type": "script"</code></pre>

    <p>For CSS files, use:</p>
    <pre><code>"type": "style"</code></pre>
  '''

  'resources\.(head|body)\.INDEX\.(src|contents)': '''
    <h4>Resource Contents</h4>

    <p>To include a resource as a file, use:</p>
    <pre><code>"src": "./path/to/file.js"</code></pre>

    <p>To include a resource as a string, use:</p>
    <pre><code>"contents": "/* JS or CSS string */"</code></pre>

    <hr>

    <p><em>Advanced</em>: You may also interpolate <code>options</code> values into <code>src</code> paths, for example:</p>

    <pre><code>"src": "./css/{{ options.theme }}.css"</code></pre>
  '''

  'options': -> '''
    <h4>Options</h4>

    <p>Allows for end-user customization of the installation of a set of resources.</p>
    <p>Options are passed back to the app JavaScript via an <code>INSTALL_OPTIONS</code> variable, and they can also be interpolated into resource <code>src</code> paths. Options follow <a href="http://json-schema.org">JSON Schema</a> for their structure.</p>

    <hr>

    <p>There are two types of options, primitive options and container options.</p>
    <p>Primitive options are objects with <code>type</code> <code>boolean</code>, <code>number</code>, <code>integer</code>, or <code>string</code> and a variety of string formats including <code>color</code>, <code>selector</code>, and others.</p>

    <p>Container options are arrays and objects which can nest other primitive and container options recursively.</p>

    <p><a class="more" target="_blank" href="https://github.com/EagerIO/DeveloperDocs/blob/master/docs/adding-your-app.md#install-json">Learn more about install.json options</a></p>
  '''

  'options\.properties(\.PROPERTY)?': '''
    <h4>Option Property</h4>

    <p>Define an individual property for end-user customization.</p>
    <p>The following is an example option which defines a simple text field to capture <code>headerText</code>:</p>

    <pre><code>"headerText": {
      "order": 1,
      "title": "Header Text",
      "description": "Appears above Plugin.",
      "type": "string",
      "default": "Welcome!"
    }</code></pre>

    <p>If the user didn’t change the default text <code>"Welcome!"</code>, the developer would get passed back the following:</p>

    <pre><code>{
      "headerText": "Welcome!
    }</code></pre>
  '''

  'options(\.properties\.PROPERTY)\.order': '''
    <h4>Option Order</h4>

    <p><em>Optional</em></p>

    <p>Whole number used to determine the order options will visually be presented to the user.</p>

    <pre><code>"order": 1</code></pre>
  '''

  'options(\.properties\.PROPERTY)+\.title': '''
    <h4>Option Title</h4>

    <p><em>Optional</em></p>

    <p>Property title. If blank, the property key will be used.</p>

    <pre><code>"title": "Header Text"</code></pre>
  '''

  'options(\.properties\.PROPERTY)+\.description': '''
    <h4>Option Description</h4>

    <p><em>Optional</em></p>

    <p>Short description of the property.</p>

    <pre><code>"description": "Appears above Plugin."</code></pre>
  '''

  'options(\.properties\.PROPERTY)+\.default': '''
    <h4>Option Description</h4>

    <p><em>Optional</em></p>

    <p>The default value to be used for a primitive option.</p>

    <pre><code>"default": "Default value"</code></pre>
  '''

  'options(\.properties\.PROPERTY)+\.(type|format)': '''
    <h4>Option Type</h4>

    <h5>Primitive option types</h5>

    <p>Element to be placed on the end-user’s website</p>

    <pre><code>{
      "type": "string",
      "format": "element"
    }</code></pre>

    <p>Location (CSS selector) on the end-user’s website</p>

    <pre><code>{
      "type": "string",
      "format": "selector"
    }</code></pre>

    <p>Image</p>

    <pre><code>{
      "type": "string",
      "format": "image"
    }</code></pre>

    <p>Color</p>

    <pre><code>{
      "type": "string",
      "format": "color"
    }</code></pre>

    <p>String</p>

    <pre><code>{
      "type": "string"
    }</code></pre>

    <p>Number</p>

    <pre><code>{
      "type": "number"
    }</code></pre>

    <p>Integer</p>

    <pre><code>{
      "type": "integer"
    }</code></pre>

    <p>Boolean</p>

    <pre><code>{
      "type": "boolean"
    }</code></pre>

    <p>String with fixed set of options</p>

    <pre><code>{
      "type": "string",
      "enum": [
        "option-a",
        "option-b"
      ],
      "enumNames": {
        "option-a": "Option A",
        "option-b": "Option B"
      }
    }</code></pre>

    <hr>

    <h5>Container option types</h5>

    <p>Nested set of options</p>

    <pre><code>{
      "type": "object",
      "properties": { ... }
    }</code></pre>

    <p>Array</p>

    <pre><code>{
      "type": "array",
      "items": {
        "type": "[ Any primitive option type or container option type ]"
      }
    }</code></pre>
  '''

  'options(\.properties\.PROPERTY)+\.enum(\.INDEX)?': '''
    <h4>Option Enum</h4>

    <p>Used to define a list of string option values for a <code>string</code> with fixed options property type.</p>

    <pre><code>{
      "type": "string",
      "enum": [
        "option-a",
        "option-b"
      ],
      "enumNames": {
        "option-a": "Option A",
        "option-b": "Option B"
      }
    }</code></pre>
  '''

  'options(\.properties\.PROPERTY)+\.enumNames(\.PROPERTY)?': '''
    <h4>Option Enum</h4>

    <p>Used to define a list of human for a <code>string</code> property type.</p>
  '''

  'options(\.properties\.PROPERTY)+\.showIf(\.PROPERTY)?': '''
    <h4>Option Enum</h4>

    <p><em>Optional</em></p>

    <p>Conditionally show or hide the option based on the value of another option.</p>

    <pre><code>{
      "theme": {
        "title": "Theme",
        "type": "string",
        "enum": [
          "default",
          "colorful"
          "minimal"
        ],
        "enumNames": {
          "default": "Default",
          "colorful": "Colorful",
          "minimal":  "Minimal"
       }
      },
      "color": {
        "title": "Color",
        "showIf": {
          "theme": "colorful"
        },
        "description": "Choose a color for the Colorful theme.",
        "type": "string",
        "format": "color",
        "default": "#e90f92"
      }
    }</code></pre>
  '''

module.exports = context
