# Description
#   Oooh... that's a paddlin'
#
# Configuration:
#   None
#
# Commands:
#   hubot simpsons me {query} - A screen cap of a simpsons episode based on the query
#
# Author:
#   Oshin Karamian

htmlparser = require "htmlparser"
Select = require("soupselect").select

module.exports = (robot) ->
  apiSearch = (query) ->
    "https://frinkiac.com/api/search?q=#{query}"

  fetchSimpsons = (msg, url) ->
    msg.http(url).get() (err, res, body) ->

      console.log(body)
      screencap = JSON.parse(body)[0]

      msg.send "https://frinkiac.com/img/#{screencap.Episode}/#{screencap.Timestamp}/medium.jpg"

  robot.respond /simpsons me\s?((?:0[1-9]|1[0-2]).?(?:0[1-9]|[1-2][0-9]|3[0-1]).?(?:20\d{2})$|.*)?/i, (msg) ->
    arg = msg.match[1]
    fetchSimpsons(msg, apiSearch(arg))
