# frozen_string_literal: true

class Contact < ApplicationRecord
  # Validations
  validates_presence_of :kind, :name

  belongs_to :kind
  has_many :phones
  has_one :address

  # Kaminari
  paginates_per 5

  accepts_nested_attributes_for :phones, allow_destroy: true
  accepts_nested_attributes_for :address, update_only: true

  def as_json(options = {})
    h = super(options)
    h[:birthdate] = (I18n.l(birthdate) unless birthdate.blank?)
    h
  end
end
