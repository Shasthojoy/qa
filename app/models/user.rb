require_dependency 'slugger'

class User < ActiveRecord::Base
  include QA::Slugger

  has_many :authorizations
  has_many :questions

  attr_accessible :authorizations_attributes, :email, :name
  accepts_nested_attributes_for :authorizations, allow_destroy: false, reject_if: proc { |obj| obj.blank? }

  is_slugged :name

  def self.find_by_hash(auth_hash)
    if auth = Authorization.where('uid = ?', auth_hash[:uid]).where('provider = ?', auth_hash[:provider]).first
      auth.user
    else
      nil
    end
  end

  def self.new_from_hash(auth_hash)
    user = User.new(
      email: auth_hash[:info][:email],
      name: auth_hash[:info][:name]
    )
    user.authorizations.new(
      email: auth_hash[:info][:email],
      provider: auth_hash[:provider],
      uid: auth_hash[:uid]
    )
    user
  end
end