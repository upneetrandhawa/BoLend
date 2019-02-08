App.notification = App.cable.subscriptions.create("NotificationChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    var mydiv = document.getElementById("dropdown-content");
    var spanTag = document.createElement('span');
    spanTag.setAttribute('class', 'unread-notification');
    spanTag.innerHTML = data["notice"];
    mydiv.insertBefore(spanTag, mydiv.firstChild);

    var no_notifications_tag = document.getElementById("no-notifications");
    if(no_notifications_tag){
        no_notifications_tag.innerHTML = "";
    }
    
    var unread_notifications_count_span = document.getElementById("unread-notifications-count");
    unread_notifications_count_span.innerHTML = "(" + data["unread_notifications_count"] + ")";

    var x = document.getElementById("snackbar");
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
  },
  
  contact_request_response: function(sender_user_name, receiver_user_name, notification) {
    return this.perform('contact_request_response', {
      sender_user_name: sender_user_name,
      receiver_user_name: receiver_user_name,
      notification: notification
    });
  }
});