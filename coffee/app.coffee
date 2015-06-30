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
#editor.setShowPrintMargin false
#editor.setOptions 'maxLines', Infinity

editorSession = editor.getSession()
editorSession.setMode 'ace/mode/json'
editorSession.setTabSize 2
editorSession.setUseWrapMode true
editorSession.setUseSoftTabs true
#editor.setOption 'wrap', 80

editor.setOption 'vScrollBarAlwaysVisible', true

setWrapBasedOnViewportWidth = ->
  wrapInCharacters = 40

  try
    characterWidth = 9.60156 # TODO - make smarter
    overlayWidth = 400 # TODO - keep in sync with CSS

    pageWidth = document.documentElement.clientWidth

    node = document.querySelector('.ace_content .ace_layer.ace_text-layer .ace_line_group')
    lineOffsetLeft = 0
    while node.parentNode isnt document.body
      lineOffsetLeft += node.offsetLeft
      node = node.parentNode

    wrapLengthPixels = pageWidth - (lineOffsetLeft + overlayWidth)
    wrapInCharacters = parseInt(wrapLengthPixels / characterWidth, 10) - 1

  editor.setOption 'wrap', wrapInCharacters
  editor.setOption 'printMargin', wrapInCharacters

setWrapBasedOnViewportWidth()
window.addEventListener 'resize', -> setWrapBasedOnViewportWidth()

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

editorSession.on 'changeScrollTop', -> positionCodeOverlay()

editor.focus()
document.documentElement.classList.add 'page-loaded'

reCache = {}
processContext = (context) ->
  for k, v of context
    re = "^#{ k }$"
    re = re.replace /PROPERTY/g, '[^\\.]+'
    re = re.replace /INDEX/g, '\\d+'

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
    aceContentEl = editorEl.querySelector '.ace_content'

    top = 0
    if rowEl and aceContentEl
      top = rowEl.offsetTop + parseInt(aceContentEl.style.marginTop, 10)

    if top + overlayEl.clientHeight > document.documentElement.clientHeight
      top = Math.max(0, document.documentElement.clientHeight - overlayEl.clientHeight)

    overlayEl.setAttribute 'overflow-y', (document.documentElement.clientHeight - overlayEl.clientHeight <= 0)
    overlayEl.style.top = top + 'px'

  position()
  setTimeout position, 50

setEditorOverlayContext = (item) ->
  contextHTML = ''
  item = path: 'default' if not item.path
  for k, re of reCache
    if re.test item.path
      if typeof context[k] is 'function'
        contextHTML = context[k](item) or ''
      else
        contextHTML = context[k] or ''

      break

  setTimeout ->
    overlayEl.innerHTML = contextHTML

positionCodeOverlay 0
setEditorOverlayContext 'default'
