ace = require('brace')
require('brace/mode/json')
require('brace/theme/textmate')

{getItemAt} = require('./parse.coffee')

INSTALL_JSON_CONTEXT =
  'default': -> '''
    <p><strong>install.json</strong></p>

    <p>install.json is a description of how to include and configure (JavaScript, CSS, and HTML)-based projects into websites.</p>
  '''

  'resources': -> '''
    <p><strong>Resources</strong></p>

    <ul>
      <li>The files you want to bundle with your app</li>
      <li>Each resource can be placed in either the <code>&lt;head&gt;</code> or <code>&lt;body&gt;</code> of the end-user’s page by adding the resource object to the <code>"resources.head"</code> or <code>"resources.body"</code> arrays, respectively.</li>
    </ul>
  '''

  'resources.head': -> '''
    <p><strong>Head Resources</strong></p>

    <ul>
      <li>The files you want to load in the head of your app</li>
      <li>Each resource file can be either JS or CSS:</li>
    </ul>

    <div class="highlight highlight-json"><pre>{
      <span class="pl-s"><span class="pl-pds">"</span>resources<span class="pl-pds">"</span></span>: {
        <span class="pl-s"><span class="pl-pds">"</span>head<span class="pl-pds">"</span></span>: [
          {
            <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>style<span class="pl-pds">"</span></span>,
            <span class="pl-s"><span class="pl-pds">"</span>src<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>./file.css<span class="pl-pds">"</span></span>
          }
        ],
        <span class="pl-s"><span class="pl-pds">"</span>body<span class="pl-pds">"</span></span>: [
          {
            <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>script<span class="pl-pds">"</span></span>,
            <span class="pl-s"><span class="pl-pds">"</span>src<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>./file.js<span class="pl-pds">"</span></span>
          }
        ]
      },
    }</pre></div>

    <ul>
    <li>Each resource can be a file in your repository or specified inline as a string. In the string or in a file, you have access to the options set by the user via a special <code>INSTALL_OPTIONS</code> object.</li>
    </ul>

    <div class="highlight highlight-json"><pre>{
      <span class="pl-s"><span class="pl-pds">"</span>resources<span class="pl-pds">"</span></span>: {
        <span class="pl-s"><span class="pl-pds">"</span>body<span class="pl-pds">"</span></span>: [
          {
            <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>script<span class="pl-pds">"</span></span>,
            <span class="pl-s"><span class="pl-pds">"</span>contents<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>console.log(INSTALL_OPTIONS);<span class="pl-pds">"</span></span>
          }
        ]
      }
    }</pre></div>

    <ul>
    <li>When specifying a <code>src</code> for a resource, you may interpolate in <code>{{ options.optionName }}</code> for the file name (assuming <code>"optionName"</code> is a specified option). This gives you a lot of control, as it allows you to include different files based on the options set by the user.</li>
    </ul></li>
  '''

  'resources.body': -> '''
    <p><strong>Body Resources</strong></p>

    <ul>
      <li>The files you want to load in the head of your app</li>
      <li>Each resource file can be either JS or CSS:</li>
    </ul>

    <div class="highlight highlight-json"><pre>{
      <span class="pl-s"><span class="pl-pds">"</span>resources<span class="pl-pds">"</span></span>: {
        <span class="pl-s"><span class="pl-pds">"</span>head<span class="pl-pds">"</span></span>: [
          {
            <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>style<span class="pl-pds">"</span></span>,
            <span class="pl-s"><span class="pl-pds">"</span>src<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>./file.css<span class="pl-pds">"</span></span>
          }
        ],
        <span class="pl-s"><span class="pl-pds">"</span>body<span class="pl-pds">"</span></span>: [
          {
            <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>script<span class="pl-pds">"</span></span>,
            <span class="pl-s"><span class="pl-pds">"</span>src<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>./file.js<span class="pl-pds">"</span></span>
          }
        ]
      },
    }</pre></div>

    <ul>
    <li>Each resource can be a file in your repository or specified inline as a string. In the string or in a file, you have access to the options set by the user via a special <code>INSTALL_OPTIONS</code> object.</li>
    </ul>

    <div class="highlight highlight-json"><pre>{
      <span class="pl-s"><span class="pl-pds">"</span>resources<span class="pl-pds">"</span></span>: {
        <span class="pl-s"><span class="pl-pds">"</span>body<span class="pl-pds">"</span></span>: [
          {
            <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>script<span class="pl-pds">"</span></span>,
            <span class="pl-s"><span class="pl-pds">"</span>contents<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>console.log(INSTALL_OPTIONS);<span class="pl-pds">"</span></span>
          }
        ]
      }
    }</pre></div>

    <ul>
    <li>When specifying a <code>src</code> for a resource, you may interpolate in <code>{{ options.optionName }}</code> for the file name (assuming <code>"optionName"</code> is a specified option). This gives you a lot of control, as it allows you to include different files based on the options set by the user.</li>
    </ul></li>
  '''

  'resources.head.0': -> INSTALL_JSON_CONTEXT['resources.head']()

  'resources.head.0.type': -> '''
    <p><strong>Resource Type</strong></p>

    <p>Resource types can either be <code>script</code> or <code>style</code>.</p>
  '''

  'resources.body.0.type': -> INSTALL_JSON_CONTEXT['resources.head.type']()

  'resources.head.0.src': -> '''
    <p><strong>Resource Contents</strong></p>

    <p>Resources contents can be specified either with a content string or via a source file.</p>

    <p><strong>Contents:</strong></p>

    <pre><code>{
      "type": "style",
      "contents": "html { background: #000; color: #fff } /* ... */"
    }</code></pre>

    <p><strong>Source:</strong></p>

    <pre><code>{
      "type": "style",
      "src": "./themes/{{ options.theme }}.css"
    }</code></pre>

  '''

  'resources.body.0.src': -> INSTALL_JSON_CONTEXT['resources.head.0.src']()
  'resources.head.0.contents': -> INSTALL_JSON_CONTEXT['resources.head.0.src']()
  'resources.body.0.contents': -> INSTALL_JSON_CONTEXT['resources.head.0.src']()

  'options': -> '''
    <li><p><strong>Options</strong></p>

    <ul>
    <li>The end-user-configurable options you want to provide to users installing your app</li>
    <li>Uses <a href="http://json-schema.org">JSON Schema</a> for its structure</li>
    <li>Passed back to you (the developer) as <code>INSTALL_OPTIONS</code> either in your resource file or resource contents string</li>
    <li>There are two types of options, primitive options and abstract options.</li>
    <li>The primitive options all can have the following optional properties:

    <ul>
    <li><code>label</code> – A text label to accompany the option input. (e.g. “Color”)</li>
    <li><code>description</code> – A longer description of the option. (e.g. “The color of the app.”)</li>
    <li><code>default</code> – The default value to be used for the option. (Keep in mind the default value must be of the <code>type</code> specified by the option and child options, if any. So for example, the default for an <code>array</code> of <code>string</code> types would be <code>["Item one", "Item two"]</code>.)</li>
    </ul></li>
    <li>Primitive option types

    <ul>
    <li>Element to be placed on the end-user’s website

    <ul>
    <li>Presented as an interactive field which lets the user visually select a location in their website <em>and then specify where an <code>&lt;eager-app&gt;</code> element will be placed relative to that location</em>. For advanced users, a text input is also provided to manually specify a CSS selector.</li>
    </ul>

    <div class="highlight highlight-json"><pre>{
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>format<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>element<span class="pl-pds">"</span></span>
    }</pre></div></li>
    <li>Location (selector) on the end-user’s website

    <ul>
    <li>Presented as an interactive field which lets the user visually select a location in their website and then specify a location on their website. For advanced users, a text input is also provided to manually specify a CSS selector.</li>
    </ul>

    <div class="highlight highlight-json"><pre>{
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>format<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>selector<span class="pl-pds">"</span></span>
    }</pre></div></li>
    <li>Image

    <ul>
    <li>Presented as an image uploader (Images are hosted by filepicker.io.)</li>
    </ul>

    <div class="highlight highlight-json"><pre>{
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>format<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>image<span class="pl-pds">"</span></span>
    }</pre></div></li>
    <li>Color

    <ul>
    <li>Presented as a color picker and accompanying text input for manually specifying a HEX value</li>
    </ul>

    <div class="highlight highlight-json"><pre>{
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>format<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>color<span class="pl-pds">"</span></span>
    }</pre></div></li>
    <li>String

    <ul>
    <li>Presented as a text input</li>
    </ul>

    <div class="highlight highlight-json"><pre>{
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
    }</pre></div></li>
    <li>Number

    <ul>
    <li>Presented as a number-style text input</li>
    </ul>

    <div class="highlight highlight-json"><pre>{
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>number<span class="pl-pds">"</span></span>
    }</pre></div></li>
    <li>Integer

    <ul>
    <li>Presented as a number-style text input</li>
    </ul>

    <div class="highlight highlight-json"><pre>{
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>integer<span class="pl-pds">"</span></span>
    }</pre></div></li>
    <li>Boolean

    <ul>
    <li>Presented as a checkbox</li>
    </ul>

    <div class="highlight highlight-json"><pre>{
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>boolean<span class="pl-pds">"</span></span>
    }</pre></div></li>
    <li>String with options

    <ul>
    <li>Select element with <code>enum</code> strings as <code>&lt;option&gt;</code>s, optionally specify <code>enumNames</code> for human-readable names</li>
    </ul>

    <div class="highlight highlight-json"><pre>{
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>enum<span class="pl-pds">"</span></span>: [
        <span class="pl-s"><span class="pl-pds">"</span>option-a<span class="pl-pds">"</span></span>,
        <span class="pl-s"><span class="pl-pds">"</span>option-b<span class="pl-pds">"</span></span>
      ],
      <span class="pl-s"><span class="pl-pds">"</span>enumNames<span class="pl-pds">"</span></span>: {
        <span class="pl-s"><span class="pl-pds">"</span>option-a<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>Option A<span class="pl-pds">"</span></span>,
        <span class="pl-s"><span class="pl-pds">"</span>option-b<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>Option B<span class="pl-pds">"</span></span>,
      }
    }</pre></div></li>
    </ul></li>
    <li>Abstract option types

    <ul>
    <li>Nested set of options

    <ul>
    <li>Presented inside of a container with its own optional label</li>
    </ul>

    <div class="highlight highlight-json"><pre>{
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>object<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>properties<span class="pl-pds">"</span></span>: {<span class="pl-ii">…</span>}
    }</pre></div></li>
    <li>Array

    <ul>
    <li>Presented as a list of a single option type (specified inside directly inside of <code>items</code>), with the ability for the user to add and remove items</li>
    </ul>

    <div class="highlight highlight-json"><pre>{
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>array<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>items<span class="pl-pds">"</span></span>: {
        <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>[ Any primitive option type or object abstract option type ]<span class="pl-pds">"</span></span>
      }
    }</pre></div></li>
    </ul></li>
    </ul></li>
    <li><p><strong>Hooks</strong></p>

    <ul>
    <li>The hooks section allows you to integrate your Eager app's installation with your systems.  See the <a href="https://github.com/EagerIO/DeveloperDocs/blob/master/docs/hooks.md">hooks documentation</a> for more details.</li>
    </ul></li>
    </ul>
  '''

editorId = 'editor'
editorEl = document.getElementById editorId

overlayEl = document.querySelector '.code-overlay'

editor = ace.edit editorId
editor.setTheme 'ace/theme/textmate'
editor.setShowPrintMargin false
editor.setOptions maxLines: Infinity

editorSession = editor.getSession()
editorSession.setMode 'ace/mode/json'
editorSession.setTabSize 2
editorSession.setUseSoftTabs true

getEditorLineHeight = ->
  height = 21
  try
    height = parseInt editorEl.querySelector('.ace_layer.ace_text-layer .ace_line').style.height, 10
  return height

selection = editorSession.getSelection()
selection.on 'changeCursor', ->
  selectionRange = editor.getSelectionRange()

  row = selectionRange.start.row
  col = selectionRange.start.column
  src = editorSession.getValue()

  try
    item = getItemAt src, row, col
    itemErrored = false
    setEditorOverlayContext item.path
    #console.log item.path

  catch
    itemErrored = true

  positionCodeOverlay row
  setCodeOverlayDisplay itemErrored, selectionRange

simplifyArrayPaths = (path) ->
  path.replace /\.\d?\./, '.0.'

setCodeOverlayDisplay = (itemErrored, selectionRange) ->
  if not itemErrored and selectionRange.start.column is selectionRange.end.column and selectionRange.start.row is selectionRange.end.row
    overlayEl.style.display = 'block'
  else
    overlayEl.style.display = 'none'

positionCodeOverlay = (row) ->
  editorLineHeight = getEditorLineHeight()

  overlayEl.style.top = "#{ (row + 1) * editorLineHeight }px"

setEditorOverlayContext = (path) ->
  contextPath = simplifyArrayPaths path
  contextHTMLFn = INSTALL_JSON_CONTEXT[contextPath] or INSTALL_JSON_CONTEXT['default']
  overlayEl.innerHTML = contextHTMLFn()

positionCodeOverlay 0
setEditorOverlayContext 'default'
