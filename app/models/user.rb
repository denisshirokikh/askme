require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new
  VALID_EMAIL = /\A\w+@\w+\.\w+\z/i
  VALID_USERNAME = /\A\w+\z/i
  COLOR_REGEXP = /\A#\h{3}{1,2}\z/

  attr_accessor :password

  before_validation :string_downcase
  before_save :encrypt_password

  has_many :questions

  validates :email, :username, uniqueness: true
  validates :email,
            format: { with: VALID_EMAIL }
  validates :username,
            format: { with: VALID_USERNAME },
            length: {maximum: 40}
  validates :password, presence: true, confirmation: true, on: :create
  validates :profile_color, format: { with: COLOR_REGEXP }

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)
    return nil unless user.present?
    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )
    return user if user.password_hash == hashed_password
    nil
  end

  private

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
          password, password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
      )

    end
  end

  def string_downcase
    email&.downcase!
    username&.downcase!
  end
end

