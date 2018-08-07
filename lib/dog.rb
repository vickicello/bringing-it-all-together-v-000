class Dog

  attr_accessor :id, :name, :breed

  def initialize(id: nil, name:, breed:)
    @id = id
    @name = name
    @breed = breed
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

    # def update
    #   sql = "UPDATE dogs SET name = ?, breed = ? WHERE id = ?"
    #   DB[:conn].execute(sql, self.name, self.breed, self.id)
    # end

    def save
        sql = "INSERT INTO dogs (name, breed) VALUES (?, ?);"
        DB[:conn].execute(sql, self.name, self.breed)
        @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
        self
     end

    def update
      sql = "UPDATE dogs SET name = ?, breed = ? WHERE id = ?;"
      DB[:conn].execute(sql, self.name, self.breed, self.id)
    end

    def self.create(name:, breed:)
      dog = Dog.new(name: name, breed: breed)
      dog.save
      dog
    end

    def self.find_by_id(id)
      sql = "SELECT * FROM dogs WHERE id = ?"
      result = DB[:conn].execute(sql, id)[0]
      # if !result.nil? && result.length > 0
        Dog.new(id: result[0], name: result[1], breed: result[2])
      # end
    end

    def self.new_from_db(row)
      dog = Dog.new(row[0],row[1],row[2])
    end




  # def self.find(id, db)
  #    pokemon_data = db.execute("SELECT * FROM pokemon WHERE id = ?", id).flatten
  #    self.new(id: pokemon_data[0], name: pokemon_data[1], type: pokemon_data[2], db: db, hp: pokemon_data[3] )
  #  end


end
