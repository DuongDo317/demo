class User < ApplicationRecord
  extend Enumerize
  enumerize :status, in: { deactivate: 0, active: 1 }
end
