class Price < ApplicationRecord
  belongs_to :platform
  belongs_to :coin
end
