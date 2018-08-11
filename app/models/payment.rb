class Payment < ApplicationRecord
  has_many :messages

  #You will probably need to move the Requests and imports over here
end
