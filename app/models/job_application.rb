class JobApplication < ApplicationRecord

    has_many :trackers, dependent: :destroy
    
end
