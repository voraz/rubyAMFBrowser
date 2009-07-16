class Company
  generator_for :name, :method=>:some_name
  
  def self.some_name
    Faker::Company.name
  end
  
end