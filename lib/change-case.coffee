ChangeCase = require 'change-case'

module.exports =
  activate: (state) ->
    atom.commands.add 'atom-workspace', "ng-case", ->
      editor = atom.workspace.getActiveTextEditor()
      return unless editor?

      options = {}
      options.wordRegex = /^[\t ]*$|[^\s\/\\\(\)"':,\.;<>~!@#\$%\^&\*\|\+=\[\]\{\}`\?]+/g
      for cursor in editor.getCursors()
        position = cursor.getBufferPosition()

        range = cursor.getCurrentWordBufferRange(options)
        text = editor.getTextInBufferRange(range)

        command = if text.indexOf('-') === -1 then 'paramCase' else 'camelCase'
        method = Commands[command]
        converter = ChangeCase[method]

        newText = converter(text)
        editor.setTextInBufferRange(range, newText)
