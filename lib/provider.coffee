fs = require 'fs'
path = require 'path'

module.exports =
  selector: '.source.cs'
  suggestionPriority: -1
  filterSuggestions: true
  completions: {}

  loadCompletions: -> #辞書データの読み込み
    fs.readFile(
      path.resolve(__dirname, '.', 'dic.json'),
      (err, data) => @completions = JSON.parse(data) unless err?)

  getSuggestions: ({prefix}) -> #変換候補を返す
    return [] if prefix.length < 3 #3文字以上から候補を返す

    completions = []
    for type, names of @completions
      for name in names
        completions.push({type: type, text: name})
    completions
