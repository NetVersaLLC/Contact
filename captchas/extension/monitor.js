chrome.extension.onMessage.addListener(
  function(request, sender, sendResponse) {
    if (request.greeting == "captcha")
      var notification = webkitNotifications.createNotification(
          '64.png',
          'CAPTCHA',
          'CAPTCHA is waiting to solve!'
      );
      notification.show();
      sendResponse({farewell: "displayed"});
});
