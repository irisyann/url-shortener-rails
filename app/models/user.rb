# email:string
# password_digest:string
# 
# password:string virtual
# password_confirmation:string virtual

class User < ApplicationRecord
    has_secure_password
    validates :email, 
        presence: true, 
        uniqueness: true,
        format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email" }

    validates :password, 
        presence: true, 
        length: { minimum: 6 }

    validates :password_confirmation, 
        presence: true

    # has_many :urls, dependent: :destroy
    # has_many :visits, through: :urls
    # has_many :visitors, through: :visits, source: :user
    
    # validates :email, presence: true, uniqueness: true
    # validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    
    # attr_reader :password
    
    # def self.find_by_credentials(email, password)
    #     user = User.find_by(email: email)
    #     return nil unless user
    #     user.is_password?(password) ? user : nil
    # end
    
    # def password=(password)
    #     @password = password
    #     self.password_digest = BCrypt::Password.create(password)
    # end
    
    # def is_password?(password)
    #     BCrypt::Password.new(self.password_digest).is_password?(password)
    # end
    
    # def reset_session_token!
    #     self.session_token = SecureRandom.urlsafe_base64
    #     self.save!
    #     self.session_token
    # end
    
    # private
    
    # def ensure_session_token
    #     self.session_token ||= SecureRandom.urlsafe_base64
    # end
end
