ace = require('brace')
require('brace/mode/json')
require('brace/theme/textmate')

{getItemAt} = require('./parse.coffee')

scrollbarWidth = do ->
  scrollEl = document.createElement 'div'
  scrollEl.style.cssText = 'width: 100px; height: 100px; overflow: scroll; position: absolute; left: -99999px'
  document.body.appendChild scrollEl
  scrollbarWidth = scrollEl.offsetWidth - scrollEl.clientWidth
  document.body.removeChild scrollEl
  return scrollbarWidth

scrollbarWidthAdjustStyles = """
  .code-editor .code-property-path {
    right: #{ scrollbarWidth }px
  }
"""

style = document.createElement 'style'
style.innerHTML = scrollbarWidthAdjustStyles
document.body.appendChild style

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
overlayElContent = document.querySelector '.code-overlay-content'
propertyPathEl = document.querySelector '.code-property-path'

setWrapBasedOnViewportWidth = ->
  wrapInCharacters = 40

  pageWidth = document.documentElement.clientWidth
  characterWidth = 9.60156 # TODO - make smarter

  # TODO - keep this in sync with CSS
  if pageWidth < 1040
    editor.setOption 'wrap', 'free'

  else
    # TODO - keep this in sync with CSS
    if pageWidth < 1440
      overlayWidth = 400
    else
      overlayWidth = 480

    try
      node = document.querySelector '.ace_content .ace_layer.ace_text-layer .ace_line_group'
      lineOffsetLeft = 0
      while node.parentNode isnt document.body
        lineOffsetLeft += node.offsetLeft
        node = node.parentNode

      wrapLengthPixels = pageWidth - (lineOffsetLeft + overlayWidth)
      wrapInCharacters = parseInt(wrapLengthPixels / characterWidth, 10) - 1

    editor.setOption 'wrap', wrapInCharacters

setCodeContextDisplay = (itemErrored, selectionRange) ->
  if not itemErrored and selectionRange.start.column is selectionRange.end.column and selectionRange.start.row is selectionRange.end.row
    overlayEl.style.display = 'block'
    propertyPathEl.style.display = 'block'
  else
    overlayEl.style.display = 'none'
    propertyPathEl.style.display = 'none'

positionCodeOverlay = ->
  rowEl = editorEl.querySelector '.ace_content .ace_marker-layer .ace_active-line'
  aceContentEl = editorEl.querySelector '.ace_content'

  if not rowEl or not aceContentEl
    overlayEl.setAttribute 'target-off-screen', ''
    return

  top = 0
  if rowEl and aceContentEl
    overlayEl.removeAttribute 'target-off-screen'
    top = rowEl.offsetTop + parseInt(aceContentEl.style.marginTop, 10)

  if top + overlayEl.clientHeight > document.documentElement.clientHeight
    top = Math.max(0, document.documentElement.clientHeight - overlayEl.clientHeight)

  overlayEl.setAttribute 'overflow-y', (document.documentElement.clientHeight - overlayEl.clientHeight <= 0)
  overlayEl.style.top = top + 'px'

setEditorOverlayContext = (item) ->
  contextHTML = ''
  item = path: '' if not item?.path
  for k, re of reCache
    if re.test item.path
      if typeof context[k] is 'function'
        contextHTML = context[k](item) or ''
      else
        contextHTML = context[k] or ''

      break

  overlayElContent.innerHTML = contextHTML

editor = ace.edit editorId
editor.setTheme 'ace/theme/textmate'
editor.setShowPrintMargin false

editorSession = editor.getSession()
editorSession.setMode 'ace/mode/json'
editorSession.setTabSize 2
editorSession.setUseWrapMode true
editorSession.setUseSoftTabs true
editor.setOption 'vScrollBarAlwaysVisible', true
editor.setOption 'scrollPastEnd', true

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

window.addEventListener 'resize', positionCodeOverlay

editor.renderer.on 'afterRender', positionCodeOverlay

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

setEditorOverlayContext()

setUpShare = ->
  _Drop = Drop.createContext
    classPrefix: 'share'

  target = document.querySelector '.share-target'

  drop = new _Drop
    target: target
    classes: 'share'
    openOn: 'click'
    position: 'top left'
    constrainToWindow: true
    constrainToScrollParent: false
    content: """
       <ul>
         <li><a href="https://www.facebook.com/sharer/sharer.php?u=http%3A%2F%2F#{ format }.json.is" target="_blank" class="share-icon-facebook">Facebook</a></li>
         <li><a href="https://twitter.com/intent/tweet?name=%20&url=http://#{ format }.json.is&text=Open-source%20documentation%20for%20#{ format }.json%20files.&via=EagerIO" target="_blank" class="share-icon-twitter">Twitter</a></li>
         <li><a href="mailto:?subject=Open-source documentation for #{ format }.json files&body=Website: http://#{ format }.json.is" target="_blank" class="share-icon-email">Email</a></li>
       </ul>
    """

setUpShare()
