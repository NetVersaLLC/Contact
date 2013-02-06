function checkForCaptchas() {
  $.getJSON('/list.json', function(data) {
    console.log(data);
    if (data.length > 0) {
      html = ''
      $.each(data, function(i,e) {
        html += '<tr>';
        html += '<td>'+i+'</td>';
        html += '<td><img src="/captcha/'+e+'" /></td>';
        html += '<td><input type="text" value="" name="'+e+'" class="input-medium search-query" /><button class="btn solve">Submit</button></td>';
      });
      chrome.extension.sendMessage({greeting: "captcha"}, function(response) {
        console.log(response.farewell);
      });
      window.clearInterval(window.checkForCaptchasInterval);
      document.getElementById('solutions').innerHTML = html;
      $('.solve').click(function (e) {
        input = e.target.previousSibling;
        data = {
          file: input.name,
          text: input.value
        };
        $.post('/solve.json', data, function(data) {
          console.log(data);
          window.checkForCaptchasInterval = window.setInterval(checkForCaptchas, 1000);
        });
      });
    }
  });
}

$(document).ready(function() {
  window.checkForCaptchasInterval = window.setInterval(checkForCaptchas, 1000);
});
