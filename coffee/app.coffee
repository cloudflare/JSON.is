ace = require('brace')
require('brace/mode/json')
require('brace/theme/textmate')

{getItemAt} = require('./parse.coffee')

INSTALL_JSON_CONTEXT =
  'default': -> '''
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

  'resources': -> '''
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

  'resources.head': -> '''
    <h4>Head Resources</h4>

    <p>The JavaScript and CSS files you want to be included in the <code>&lt;head&gt;</code> of the page.</p>

    <pre><code>"head": [
      {
        "type": "script",
        "src": "./file.js"
      }
    ]</code></pre>
  '''

  'resources.body': -> '''
    <h4>Body Resources</h4>

    <p>The JavaScript and CSS files you want to be included in the <code>&lt;body&gt;</code> of the page.</p>

    <pre><code>"body": [
      {
        "type": "script",
        "src": "./file.js"
      }
    ]</code></pre>
  '''

  'resources.head.0': -> INSTALL_JSON_CONTEXT['resources.head']()
  'resources.body.0': -> INSTALL_JSON_CONTEXT['resources.head']()

  'resources.head.0.type': -> '''
    <h4>Resource Type</h4>

    <p>For JavaScript files, use:</p>
    <pre><code>"type": "script"</code></pre>

    <p>For CSS files, use:</p>
    <pre><code>"type": "style"</code></pre>
  '''

  'resources.body.0.type': -> INSTALL_JSON_CONTEXT['resources.head.0.type']()

  'resources.head.0.src': (item) -> '''
    <h4>Resource Contents</h4>

    <p>To include a resource as a file, use:</p>
    <pre><code>"src": "./path/to/file.js"</code></pre>

    <p>To include a resource as a string, use:</p>
    <pre><code>"contents": "/* JS or CSS string */"</code></pre>

    <hr>

    <p><em>Advanced</em>: You may also interpolate <code>options</code> values into <code>src</code> paths, for example:</p>

    <pre><code>"src": "./css/{{ options.theme }}.css"</code></pre>
  '''

  'resources.body.0.src': -> INSTALL_JSON_CONTEXT['resources.head.0.src']()
  'resources.head.0.contents': -> INSTALL_JSON_CONTEXT['resources.head.0.src']()
  'resources.body.0.contents': -> INSTALL_JSON_CONTEXT['resources.head.0.src']()

  'options': -> '''
    <h4>Options</h4>

    <p>Allows for end-user customization of the installation of a set of resources.</p>
    <p>Options are passed back to the app JavaScript via an <code>INSTALL_OPTIONS</code> variable, and they can also be interpolated into resource <code>src</code> paths. Options follow <a href="http://json-schema.org">JSON Schema</a> for their structure.</p>

    <hr>

    <p>There are two types of options, primitive options and abstract options.</p>
    <p>Primitive options are objects with <code>type</code> <code>boolean</code>, <code>number</code>, <code>integer</code>, or <code>string</code> and a variety of string formats including <code>color</code>, <code>selector</code>, and others.</p>

    <p>Abstract options are arrays and objects which can nest other primitive and abstract options recursively.</p>

    <p><a class="more" target="_blank" href="https://github.com/EagerIO/DeveloperDocs/blob/master/docs/adding-your-app.md#install-json">Learn more about install.json options</a></p>
  '''

  'options.properties': -> '''
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

  'options.properties.*': -> INSTALL_JSON_CONTEXT['options.properties']()

  'options.properties.*.order': -> '''
    <h4>Option Order</h4>

    <p><em>Optional</em></p>

    <p>Whole number used to determine the order options will visually be presented to the user.</p>

    <pre><code>"order": 1</code></pre>
  '''

  'options.properties.*.properties.*.order': -> INSTALL_JSON_CONTEXT['options.properties.*.order']()
  'options.properties.*.properties.*.properties.*.order': -> INSTALL_JSON_CONTEXT['options.properties.*.order']()
  'options.properties.*.properties.*.properties.*.properties.*.order': -> INSTALL_JSON_CONTEXT['options.properties.*.order']()

  'options.properties.*.title': -> '''
    <h4>Option Title</h4>

    <p><em>Optional</em></p>

    <p>Property title. If blank, the property key will be used.</p>

    <pre><code>"title": "Header Text"</code></pre>
  '''

  'options.properties.*.properties.*.title': -> INSTALL_JSON_CONTEXT['options.properties.*.title']()
  'options.properties.*.properties.*.properties.*.title': -> INSTALL_JSON_CONTEXT['options.properties.*.title']()
  'options.properties.*.properties.*.properties.*.properties.*.title': -> INSTALL_JSON_CONTEXT['options.properties.*.title']()

  'options.properties.*.description': -> '''
    <h4>Option Description</h4>

    <p><em>Optional</em></p>

    <p>Short description of the property.</p>

    <pre><code>"description": "Appears above Plugin."</code></pre>
  '''

  'options.properties.*.properties.*.description': -> INSTALL_JSON_CONTEXT['options.properties.*.description']()
  'options.properties.*.properties.*.properties.*.description': -> INSTALL_JSON_CONTEXT['options.properties.*.description']()
  'options.properties.*.properties.*.properties.*.properties.*.description': -> INSTALL_JSON_CONTEXT['options.properties.*.description']()

  'options.properties.*.default': -> '''
    <h4>Option Description</h4>

    <p><em>Optional</em></p>

    <p>The default value to be used for a primitive option.</p>

    <pre><code>"default": "Default value"</code></pre>
  '''

  'options.properties.*.properties.*.default': -> INSTALL_JSON_CONTEXT['options.properties.*.default']()
  'options.properties.*.properties.*.properties.*.default': -> INSTALL_JSON_CONTEXT['options.properties.*.default']()
  'options.properties.*.properties.*.properties.*.properties.*.default': -> INSTALL_JSON_CONTEXT['options.properties.*.default']()

  'options.properties.*.type': -> '''
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

    <h5>Abstract option types</h5>

    <p>Nested set of options</p>

    <pre><code>{
      "type": "object",
      "properties": { ... }
    }</code></pre>

    <p>Array</p>

    <pre><code>{
      "type": "array",
      "items": {
        "type": "[ Any primitive option type or object abstract option type ]"
      }
    }</code></pre>
  '''

  'options.properties.*.format': -> INSTALL_JSON_CONTEXT['options.properties.*.type']()
  'options.properties.*.properties.*.type': -> INSTALL_JSON_CONTEXT['options.properties.*.type']()
  'options.properties.*.properties.*.format': -> INSTALL_JSON_CONTEXT['options.properties.*.type']()
  'options.properties.*.properties.*.properties.*.type': -> INSTALL_JSON_CONTEXT['options.properties.*.type']()
  'options.properties.*.properties.*.properties.*.format': -> INSTALL_JSON_CONTEXT['options.properties.*.type']()
  'options.properties.*.properties.*.properties.*.properties.*.type': -> INSTALL_JSON_CONTEXT['options.properties.*.type']()
  'options.properties.*.properties.*.properties.*.properties.*.format': -> INSTALL_JSON_CONTEXT['options.properties.*.type']()

  'options.properties.*.enum': -> '''
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

  'options.properties.*.enum.0': -> INSTALL_JSON_CONTEXT['options.properties.*.enum']()
  'options.properties.*.properties.*.enum': -> INSTALL_JSON_CONTEXT['options.properties.*.enum']()
  'options.properties.*.properties.*.enum.0': -> INSTALL_JSON_CONTEXT['options.properties.*.enum']()
  'options.properties.*.properties.*.properties.*.enum': -> INSTALL_JSON_CONTEXT['options.properties.*.enum']()
  'options.properties.*.properties.*.properties.*.enum.0': -> INSTALL_JSON_CONTEXT['options.properties.*.enum']()
  'options.properties.*.properties.*.properties.*.properties.*.enum': -> INSTALL_JSON_CONTEXT['options.properties.*.enum']()
  'options.properties.*.properties.*.properties.*.properties.*.enum.0': -> INSTALL_JSON_CONTEXT['options.properties.*.enum']()

  'options.properties.*.enumNames': -> '''
    <h4>Option Enum</h4>

    <p>Used to define a list of human for a <code>string</code> property type.</p>
  '''

  'options.properties.*.enumNames.*': -> INSTALL_JSON_CONTEXT['options.properties.*.enumNames']()
  'options.properties.*.properties.*.enumNames': -> INSTALL_JSON_CONTEXT['options.properties.*.enumNames']()
  'options.properties.*.properties.*.enumNames.*': -> INSTALL_JSON_CONTEXT['options.properties.*.enumNames']()
  'options.properties.*.properties.*.properties.*.enumNames': -> INSTALL_JSON_CONTEXT['options.properties.*.enumNames']()
  'options.properties.*.properties.*.properties.*.enumNames.*': -> INSTALL_JSON_CONTEXT['options.properties.*.enumNames']()
  'options.properties.*.properties.*.properties.*.properties.*.enumNames': -> INSTALL_JSON_CONTEXT['options.properties.*.enumNames']()
  'options.properties.*.properties.*.properties.*.properties.*.enumNames.*': -> INSTALL_JSON_CONTEXT['options.properties.*.enumNames']()

  'options.properties.*.showIf': -> '''
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

  'options.properties.*.showIf.*': -> INSTALL_JSON_CONTEXT['options.properties.*.showIf']()
  'options.properties.*.properties.*.showIf': -> INSTALL_JSON_CONTEXT['options.properties.*.showIf']()
  'options.properties.*.properties.*.showIf.*': -> INSTALL_JSON_CONTEXT['options.properties.*.showIf']()
  'options.properties.*.properties.*.properties.*.showIf': -> INSTALL_JSON_CONTEXT['options.properties.*.showIf']()
  'options.properties.*.properties.*.properties.*.showIf.*': -> INSTALL_JSON_CONTEXT['options.properties.*.showIf']()
  'options.properties.*.properties.*.properties.*.properties.*.showIf': -> INSTALL_JSON_CONTEXT['options.properties.*.showIf']()
  'options.properties.*.properties.*.properties.*.properties.*.showIf.*': -> INSTALL_JSON_CONTEXT['options.properties.*.showIf']()


editorId = 'editor'
editorEl = document.getElementById editorId

overlayEl = document.querySelector '.code-overlay'
propertyPathEl = document.querySelector '.code-property-path'

editor = ace.edit editorId
editor.setTheme 'ace/theme/textmate'
editor.setShowPrintMargin false
editor.setOptions maxLines: Infinity

editorSession = editor.getSession()
editorSession.setMode 'ace/mode/json'
editorSession.setTabSize 2
editorSession.setUseSoftTabs true
editorSession.setUseWrapMode true

selection = editorSession.getSelection()
selection.on 'changeCursor', ->
  selectionRange = editor.getSelectionRange()

  row = selectionRange.start.row
  col = selectionRange.start.column
  src = editorSession.getValue()

  try
    item = getItemAt src, row, col
    itemErrored = false
    setEditorOverlayContext item
    propertyPathEl.innerText = item.path

  catch
    itemErrored = true

  positionCodeOverlay()
  setCodeContextDisplay itemErrored, selectionRange

window.addEventListener 'resize', -> positionCodeOverlay()

document.documentElement.classList.add 'page-loaded'

simplifyArrayPaths = (path) ->
  path = path.replace /\.\d$/, '.0'
  path = path.replace /\.\d.*\./, '.0.'
  path = path.replace /^(options\.properties\.)([^\.]*)/, '$1*'
  path = path.replace /(\.properties\.)([^\.]*)/g, '$1*'
  path = path.replace /(\.enumNames\.)([^\.]*)/g, '$1*'
  path = path.replace /(\.showIf\.)([^\.]*)/g, '$1*'
  path

setCodeContextDisplay = (itemErrored, selectionRange) ->
  if not itemErrored and selectionRange.start.column is selectionRange.end.column and selectionRange.start.row is selectionRange.end.row
    overlayEl.style.display = 'block'
    propertyPathEl.style.display = 'block'
  else
    overlayEl.style.display = 'none'
    propertyPathEl.style.display = 'none'

positionCodeOverlay = ->
  position = ->
    rowEl = editorEl.querySelector '.ace_content .ace_marker-layer .ace_active-line'
    if rowEl
      overlayEl.style.top = rowEl.offsetTop + 'px'

  position()
  setTimeout position, 50

setEditorOverlayContext = (item) ->
  item = path: 'default' if not item.path
  contextPath = simplifyArrayPaths item.path
  contextHTML = INSTALL_JSON_CONTEXT[contextPath]?(item) or ''
  setTimeout ->
    overlayEl.innerHTML = contextHTML

positionCodeOverlay 0
setEditorOverlayContext 'default'
