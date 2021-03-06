compile = require('coffee-script').compile
fs = require 'fs'

module.exports.makefile = (file,source, cb) -> 
	fs.readFile source+'/'+file+'.coffee', 'utf8', (err,data) ->
		cb compile data
		return
	return
module.exports.middleware = (source) ->
	(req,res,next) ->
		path = req.url.split('/')
		file = path[path.length-1].split('.')
		extention = file[1]
		if extention == 'js'
			module.exports.makefile file[0],source, (data) ->
				res.send data
		else
			next();
