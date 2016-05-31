# Description:
#   Create pull requests in Github repository
#
# Commands:
# <hubot_name> create pr <repo_name>/head to <base> - create a new pull request

repo  = process.env.HUBOT_GITHUB_ISSUE_REPO or "naoyamuto/todo"

module.exports = (robot) ->
  github = require("githubot")(robot)

  unless (url_api_base = process.env.HUBOT_GITHUB_API)?
    url_api_base = "https://api.github.com"

  # list issues


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
