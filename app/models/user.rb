class User < ApplicationRecord
  has_many :user_infos
  has_many :user_histories

  extend Enumerize
  enumerize :status, in: { deactivate: 0, active: 1 }
end
