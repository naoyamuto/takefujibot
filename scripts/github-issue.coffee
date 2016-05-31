# Description:
#   Create pull requests in Github repository
#
# Commands:
# <hubot_name> list issue - list issues
# <hubot_name> create issue <title> - create an issue


repo  = process.env.HUBOT_GITHUB_ISSUE_REPO or "naoyamuto/todo"

module.exports = (robot) ->
  github = require("githubot")(robot)

  unless (url_api_base = process.env.HUBOT_GITHUB_API)?
    url_api_base = "https://api.github.com"

  # list issues
  robot.respond /list issue$/i, (msg) ->
    url = "#{url_api_base}/repos/#{repo}/issues"

    github.get url, (issues) ->
      issues = issues.sort (a,b) -> a.number > b.number
      texts = ["https://github.com/#{repo}/issues"]
      for i in issues
        texts.push "[##{i.number}] #{i.title}"
      msg.send texts.join '\n'


  # create an issue
  robot.respond /create issue (.+)$/i, (msg) ->
    title = msg.match[1]
    url = "#{url_api_base}/repos/#{repo}/issues"

    params = {
      "title": title
      "labels": ["Hubot"]
    }

    github.post url, params, (issue) ->
      text = "A new issue was created!" + issue.html_url
      msg.send text
