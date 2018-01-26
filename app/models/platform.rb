class Platform < ApplicationRecord
 has_many :prices, dependent: :destroy
 has_many :coins, through: :prices
 validates :name, presence: true, uniqueness: true, case_sensivtive: false

end
