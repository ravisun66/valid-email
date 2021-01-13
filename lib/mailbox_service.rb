### service to connect and check the email from the mailboxlayer : https://mailboxlayer.com/documentation
class MailboxService
  include HTTParty
  base_uri 'http://apilayer.net/api' ### mailbox base url
  
  ### Mailboxlayer api key
  API_KEY = Rails.application.credentials.mailbox_key
  
  def initialize
    @options = { query: { access_key: API_KEY} }
  end

  def valid_email?(email)
    response = self.class.get("/check", {query: @options[:query].merge(
      {email: email}
    )}).parsed_response
    
    if response['format_valid'] && response['mx_found'] && response['smtp_check'] &&
      !response['catch_all']
      return true
    else
      return false
    end
  end
end