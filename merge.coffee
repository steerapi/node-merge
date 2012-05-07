fs = require "node-fs"
path = require "path"
exports.mergeTo = (f1,f2)->
  files = fs.readdirSync f1
  for file in files
    stats = fs.lstatSync("#{f1}/#{file}");
    if stats.isDirectory()
      merge("#{f1}/#{file}","#{f2}/#{file}")
    else
      if not path.existsSync("#{f2}/#{file}")
        fs.mkdirSync("#{f2}/#{file}".split("/")[..-2].join("/"),0o755,true)
        fs.writeFileSync("#{f2}/#{file}",fs.readFileSync("#{f1}/#{file}"));
        console.log "Merged #{f2}/#{file}."
      else
        console.log "Cannot merge #{f2}/#{file}. File exists."
