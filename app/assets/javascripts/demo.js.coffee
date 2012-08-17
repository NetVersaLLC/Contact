window.storeName = 'TheBathroomSupply'

window.urlsForCheckbox = [
  "https://twitter.com/STORENAME",
  "https://www.facebook.com/pages/STORENAME/128950690507857",
  "http://www.yelp.com/biz/STORENAME",
  "https://foursquare.com/user/5368747",
  "http://www.mapquest.com/places/STORENAME-273654917/",
  "http://orangecounty.citysearch.com/profile/602444911/costa_mesa_ca/STORENAME.html",
  "http://ezlocal.com/ca/costa-mesa/business/710974076",
  "http://www.merchantcircle.com/business/STORENAME.Costa.Mesa.714-437-1571",
  "http://citygrid.com/STORENAME",
  "https://plus.google.com/111638459682317353165/about?enfplm",
  "http://www.kudzu.com/m/STORENAME-19856430",
  "http://local.yahoo.com/info-94176119-STORENAME-costa-mesa-costa-mesa",
  "http://www.yellowbot.com/STORENAME-llc-irvine-ca.html"
]

window.currentCheckbox = 1

window.displayCheckbox = ()->
  num = window.currentCheckbox
  $('#checkbox'+num).html('<img src="/assets/check.png" class="checkicon" />')
  $('#social'+num).html( '<a href="'+window.urlsForCheckbox[num-1].replace("STORENAME", window.storeName)+'">Link to Profile</a>')
  console.log("1")
  if $('#checkbox'+(num+1))
    console.log("2")
    window.currentCheckbox = num+1
    setTimeout(window.displayCheckbox, 1500+Math.random(7000))

window.startJobs = ()->
  window.currentCheckbox = 1
  setTimeout(window.displayCheckbox, 1800)

$(document).ready ->
  $('#startJobs').click ->
    window.startJobs()
