
class Person

  if(ENV['DATABASE_URL'])
        uri = URI.parse(ENV['DATABASE_URL'])
        DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
    else
        DB = PG.connect(host: "localhost", port: 5432, dbname: 'baseball_backend_development')
    end

  def self.all
    results = DB.exec("SELECT * FROM person;")
    results.each do |result|
      puts result
    end
  end

  def self.find(id)
    results = DB.exec("SELECT * FROM person WHERE id =#{id};")
    return {
      "id" => results.first["id"].to_i,
      "name" => results.first["name"],
      "age" => results.first["age"].to_i,
      "interest" => results.first["interest"]
    }
  end

  def self.create(opts)
    results = DB.exec(
      <<-SQL
          INSERT INTO person (name, age, interest)
          VALUES (
            '#{opts["name"]}',
            #{opts["age"]},
            '#{opts["interest"]}'
          )
          RETURNING id, name, age, interest;
      SQL
    )
    return {
      "id" => results.first["id"].to_i,
      "name" => results.first["name"],
      "age" => results.first["age"].to_i,
      "interest" => results.first["interest"]
    }
  end

  def self.delete(id)
    results = DB.exec("DELETE FROM person WHERE id=#{id};")
    return {"deleted" => true}
  end

  def self.update(id, opts)
    results = DB.exec(
      <<-SQL
          UPDATE person
          SET name='#{opts["name"]}', age=#{opts["age"]}, interest='#{opts["interest"]}'
          WHERE id=#{id}
          RETURNING id, name, age, interest;
      SQL
    )
    return {
      "id" => results.first["id"].to_i,
      "name" => results.first["name"],
      "age" => results.first["age"].to_i,
      "interest" => results.first["interest"]
    }
  end

end
