# Description:
#   Create pull requests in Github repository
#
# Commands:
# hubot deploy <repo_name>/<head> into <base> - create pull request

module.exports = (robot) ->
  github = require("githubot")(robot)

  unless (url_api_base = process.env.HUBOT_GITHUB_API)?
    url_api_base = "https://api.github.com"

  getDate = ->
    date = new Date
    yyyy = date.getFullYear()
    mm = date.getMonth()+1
    if mm < 10
      mm = "0" + mm
    dd = date.getDate()
    if dd < 10
      dd = "0" + dd
    yyyy + '/' + mm + '/' + dd

  robot.respond /deploy ([-_\.0-9a-zA-Z]+)(\/([-_\.a-zA-z0-9\/]+))? into ([-_\.a-zA-z0-9\/]+)$/i, (msg) ->
    repo = msg.match[1]
    head = msg.match[3] || "master"
    base = msg.match[4]
    url = "#{url_api_base}/repos/naoyamuto/#{repo}/pulls"

    account_name = msg.envelope.user.name || "anonymous"
    channel_name = msg.envelope.room || "anonymous"

    title = "#{getDate()} #{base} deployment by #{account_name}"

    body = "・Created By #{account_name} on #{channel_name}"

    data = {
      "title": title
      "body": body
      "head": head
      "base": base
    }

    github.post url, data, (pull) ->
      msg.send "A new pull request was created." + pull.html_url
