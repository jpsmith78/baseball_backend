
class Person

  if(ENV['DATABASE_URL'])
        uri = URI.parse(ENV['DATABASE_URL'])
        DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
    else
        DB = PG.connect(host: "localhost", port: 5432, dbname: 'baseball_backend_development')
    end


  def self.all
    results = DB.exec(
      <<-SQL
        SELECT
            person.*,
            card.id AS card_id,
            card.player,
            card.team,
            card.image,
            card.position,
            card.batting_avg
        FROM person
        LEFT JOIN card
        ON person.name = card.card_owner
        ORDER BY person.id ASC;
      SQL
    )
    person = []
    last_person_id = nil
    results.each do |result|
      if result["id"] != last_person_id
        person.push(
          {
            "id" => result["id"].to_i,
            "name" => result["name"],
            "age" => result["age"].to_i,
            "interest" => result["interest"],
            "collection" => []
          }
        )
        last_person_id = result["id"]
      end
      if result["card_id"]
        new_card = {
          "player" =>result["player"],
          "team" => result["team"],
          "image" => result["image"],
          "position" => result["position"],
          "batting_avg" => result["batting_avg"].to_f,
        }
        person.last["collection"].push(new_card)
      end
    end
    return person
  end



  def self.find(id)
    results = DB.exec(
      <<-SQL
        SELECT
            person.*,
            card.id AS card_id,
            card.player,
            card.team,
            card.image,
            card.position,
            card.batting_avg
        FROM person
        LEFT JOIN card
        ON person.name = card.card_owner
        WHERE person.id=#{id};
      SQL
    )
    collection = []
    results.each do |result|
      if result["card_id"]
        collection.push({
          "player" =>result["player"],
          "team" => result["team"],
          "image" => result["image"],
          "position" => result["position"],
          "batting_avg" => result["batting_avg"].to_f,
          })
      end
    end

    return {
      "id" => results.first["id"].to_i,
      "name" => results.first["name"],
      "age" => results.first["age"].to_i,
      "interest" => results.first["interest"],
      "collection" => collection
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
