touch = 'ontouchstart' of window
w = h = 0
positions = []
vendor = transform: 'transform'
docsLinks = null
testEl = document.createElement 'div'

capitalize = (s) ->
  s[0].toUpperCase() + s[1...]

for key, val of vendor
  vendor[key] = do ->
    for prefix in ['Webkit', 'Moz', 'ms']
      return full if (full = prefix + capitalize val) of testEl.style
    return val if val of testEl.style
    null

computePositions = ->
  for square, i in docsLinks
    {left, top} = square.getBoundingClientRect()
    positions[i] = [left, top]
  null

debounce = do ->
  timer = null
  ->
    clearTimeout timer
    timer = setTimeout computePositions, 333

damper = 10
onMove = (e) ->
  for square, i in docsLinks
    dX = e.pageX - positions[i][0] - w / 2
    dY = e.pageY - positions[i][1] - h / 2
    dist = (Math.sqrt(dX ** 2 + dY ** 2) or 1) / damper
    square.children[0].children[0].style[vendor.transform] =
      "rotateX(#{ -dY / dist }deg) rotateY(#{ dX / dist }deg)"

  null

document.addEventListener 'DOMContentLoaded', ->
  setTimeout ->
    document.documentElement.className += if touch then ' touch' else ''

  docsLinks = document.getElementById('docs').children
  w = h = parseInt window.getComputedStyle(docsLinks[0]).width, 10

  unless touch
    return unless vendor.transform
    computePositions()
    window.addEventListener 'resize', debounce
    document.addEventListener 'mousemove', onMove, false
