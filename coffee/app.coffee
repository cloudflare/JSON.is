# iOS CSS hover hack
document.addEventListener('touchstart', (->), false)

if document.getElementById 'home-page'
  require('./home.coffee')

if document.getElementById 'editor'
  require('./docBase.coffee')
