ace = require('brace')
require('brace/mode/javascript')
require('brace/theme/monokai')

{getItemAt} = require('./parse.coffee')

test = """
{
  "my": "data",
  "is": [
    {
      "awesome": "right?"
    }
  ]
}
"""

console.log getItemAt(test, 5, 12)

editor = ace.edit('editor')
editor.getSession().setMode('ace/mode/javascript')
editor.setTheme('ace/theme/monokai')
