require 'pony'

def send_fetch_email(email, drinks)
  Pony.mail to: email,
            from: "noreply@werl.me",
            subject: "test"
end

