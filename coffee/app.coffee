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
