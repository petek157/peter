class Certificate < ApplicationRecord

    has_and_belongs_to_many :resumes

end
