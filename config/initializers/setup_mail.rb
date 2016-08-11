ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :address => 'smtp.gmail.com',
    :port => 587,
    :domain => 'gmail.com',
    :user_name => 'negativ3.dom@gmail.com',
    :password => 'kenny8530',
    :authentication => :plain,
    :enable_starttls_auto => true
}