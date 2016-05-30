module.exports = (robot) ->
  # robot.respond /deploy ([-_\.0-9a-zA-Z]+)(\/([-_\.a-zA-z0-9\/]+))? into (deployment\/([-_\.a-zA-z0-9\/]+))$/i, (msg)->
  #   # repo = msg.match[1]
	# 	# head = msg.match[3] || "master"
	# 	# base = msg.match[4]
	# 	# environment = msg.match[5]
  #   msg.send "#{msg.match[1]} #{msg.match[3]} #{msg.match[4]} #{msg.match[5]}"

  # robot.respond /deploy ([-_\.0-9a-zA-Z]+)(\/([-_\.a-zA-z0-9\/]+))? into ([-_\.a-zA-z0-9\/]+)$/i, (msg) ->
  robot.respond /deploy ([-_\.0-9a-zA-Z]+)(\/([-_\.a-zA-z0-9\/]+))? into (deployment\/([-_\.a-zA-z0-9\/]+))$/i, (msg)->
    msg.send "#{msg.match[1]} #{msg.match[3]} #{msg.match[4]} #{msg.match[5]}"
