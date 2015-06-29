ace = require('brace')
require('brace/mode/json')
require('brace/theme/textmate')

{getItemAt} = require('./parse.coffee')

format = document.querySelector('html').getAttribute('data-format')
switch format
  when 'install'
    context = require('./formats/install.coffee')
  when 'package'
    context = require('./formats/package.coffee')
  when 'bower'
    context = require('./formats/bower.coffee')

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

reCache = {}
processContext = (context) ->
  for k, v of context
    re = "^#{ k }$"
    re = re.replace /PROPERTY/g, '[^\.]+'
    re = re.replace /INDEX/g, '\d+'

    reCache[k] = new RegExp re

processContext context

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
  for k, re of reCache
    if re.test item.path
      if typeof context[k] is 'function'
        contextHTML = context[k](item) or ''
      else
        contextHTML = context[k] or ''

      setTimeout ->
        overlayEl.innerHTML = contextHTML

      break

positionCodeOverlay 0
setEditorOverlayContext 'default'
