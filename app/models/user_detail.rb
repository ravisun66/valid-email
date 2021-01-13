class UserDetail < ApplicationRecord

  has_one :user_email
  validates_uniqueness_of :first_name, scope: %i[last_name url]

  def valid_email_found?
    email_combinations.each do |email|
      valid_email = MailboxService.new.valid_email?(email)
      return {email: email, valid: true} if valid_email
    end
    return {valid: false}
  end

  def email_combinations
    first_name = self.first_name&.downcase
    last_name = self.last_name&.downcase
    url = self.url&.downcase
    [
      "#{first_name}.#{last_name}@#{url}",
      "#{first_name}@#{url}",
      "#{first_name}#{last_name}@#{url}",
      "#{last_name}.#{first_name}@#{url}",
      "#{first_name[0]}.#{last_name}@#{url}",
      "#{first_name[0]}#{last_name[0]}@#{url}",
    ]
  end
end
