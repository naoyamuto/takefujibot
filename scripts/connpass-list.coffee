# Description:
#  Search event lists from connpass
#
# Commands:
# <hubot_name> search connpass lists <query> - Search event lists from connpass


module.exports = (robot) ->

  url = "http://connpass.com/api/v1/event/"

  robot.respond /\s+search\s+(connpass|conpass|comnpass)\s+(lists|list)\s+(.*)/i, (msg) ->
    query = msg.match[1]
    params = {
      "keyword": query,
      "count": 5
    }
    robot.http(url).query(params).get() (err, res, body) ->
      return msg.send err if err
      try
        data = JSON.parse(body).events
        return msg.send 'Not found' unless data
        result = ""
        Object.keys(data).forEach (key) ->
          result += (data[key].title + "\n")
          result += ("日時：" + data[key].started_at + "\n")
          result += ("URL：" + data[key].event_url + "\n")
        msg.send result
      catch e
        msg.send e.toString()
