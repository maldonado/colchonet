# encoding utf-8
class User < ActiveRecord::Base
  # defalt scope é cumulativo e sempre executado mesmo que nenhum outro scope seja utilizado.
  # default_scope where('confirmed_at IS NOT NULL')
  
  # commum scope - adicionando opcoes ao criar o objeto
  # scope :most_recent, order('created_at DESC')
  # scope :from_sampa, where(:location => 'São Paulo')
  
  # nammed scope - adicionando parametros para o scope , utilizando lambda
  # scope :from, ->(location) {where(:location => location)}
  
  scope :confirmed, where('confirmed_at IS NOT NULL')
  
  attr_accessible :bio, :email, :full_name, :location, :password, :password_confirmation
  
  has_secure_password
  before_create :generate_token
  
  validates_presence_of :email, :full_name, :location
  validates_length_of :bio, :minimum =>30, :allow_blank =>false
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates_uniqueness_of :email
  
  def generate_token
    self.confirmation_token = SecureRandom.urlsafe_base64
  end
  
  def confirm!
    return if confirmed?
    
    self.confirmed_at = Time.current
    self.confirmation_token = ''
    save!
  end
  
  def confirmed?
    confirmed_at.present?
  end
  
  def self.authenticate(email, password)
    confirmed.
    find_by_email(email).
    try(:authenticate,password)
  end
end