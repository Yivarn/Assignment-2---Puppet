class notifyclient {

  # first generate the current time
  $time = generate('/bin/date')  

  notify { 'notify_client_log':
    name => 'start time',
    message => "Agent run starting at $time",
  }
}
