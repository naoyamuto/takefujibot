# Description:
#
#
# Commands:
#   <hubot_name> show pocket lists - show pocket lists
#   <hubot_name> search pocket lists <query> - Search pocket lists by query
#
# Configration:
#   HUBOT_POCKET_KEY
#   HUBOT_POCKET_TOKEN


module.exports = (robot) ->

  consumer_key = process.env.HUBOT_POCKET_KEY
  access_token = process.env.HUBOT_POCKET_TOKEN
  url = "https://getpocket.com/v3/get"

  # Show pocket lists
  robot.respond /show pocket lists$/i, (msg) ->

    params = {
      "consumer_key": consumer_key,
      "access_token": access_token,
      "count": 10,
      "contentType": "article"
    }

    robot.http(url).query(params).get() (err, res, body) ->

      return msg.send err if err
      data = JSON.parse(body).list
      result = ""

      Object.keys(data).forEach (key) ->
        result += (data[key].given_title + "\n")
        result += (data[key].given_url + "\n")

      msg.send result

  # Search pocket lists by query
  robot.respond /search pocket lists (.*)$/i , (msg) ->

    query = msg.match[1]
    params = {
      "consumer_key": consumer_key,
      "access_token": access_token,
      "count": 10,
      "contentType": "article",
      "search": query
    }

    robot.http(url).query(params).get() (err, res, body) ->
      return msg.send err if err

      data = JSON.parse(body).list
      result = ""

      Object.keys(data).forEach (key) ->
        result += (data[key].given_title + "\n")
        result += (data[key].given_url + "\n")

      msg.send result
