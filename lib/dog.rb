class Dog

  attr_accessor :name, :breed
  attr_reader :id

  def initialize(id: = nil, name:, breed:)
    self.id = id
    self.name = name
    self.breed = breed
  end

  # def self.find(id, db)
  #    pokemon_data = db.execute("SELECT * FROM pokemon WHERE id = ?", id).flatten
  #    self.new(id: pokemon_data[0], name: pokemon_data[1], type: pokemon_data[2], db: db, hp: pokemon_data[3] )
  #  end


end
