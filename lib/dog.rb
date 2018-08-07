class Dog

  attr_accessor :id, :name, :breed

  def initialize(id: nil, name:, breed:)
    self.id = id
    self.name = name
    self.breed = breed
  end

    def self.create_table
      sql =  <<-SQL
        CREATE TABLE IF NOT EXISTS dogs (
          id INTEGER PRIMARY KEY,
          name TEXT,
          breed TEXT
          )
          SQL
      DB[:conn].execute(sql)
    end

    def self.drop_table
      sql = "DROP TABLE IF EXISTS dogs"
      DB[:conn].execute(sql)
    end

    def save
      if self.id
        self.update
      else
        sql = <<-SQL
          INSERT INTO dogs (name, breed)
          VALUES (?, ?)
       SQL
       DB[:conn].execute(sql, self.name, self.breed)
       @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
     end
    end

    def self.create(name, breed)
      dog = Dog.new(name, breed)
      dog.save
      dog
    end

    


  # def self.find(id, db)
  #    pokemon_data = db.execute("SELECT * FROM pokemon WHERE id = ?", id).flatten
  #    self.new(id: pokemon_data[0], name: pokemon_data[1], type: pokemon_data[2], db: db, hp: pokemon_data[3] )
  #  end


end
