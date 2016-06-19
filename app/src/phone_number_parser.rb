require 'phony'

def test_number(phone_number)
  if Phony.plausible?(phone_number)
    Phony.normalize(phone_number)
  elsif Phony.plausible?("+#{phone_number}")
    Phony.normalize("+#{phone_number}")
  elsif Phony.plausible?("+1#{phone_number}")
    Phony.normalize("+1#{phone_number}")
  else
    false
  end
end

def get_twilio_number(phone_number)
  "+#{phone_number}"
end

