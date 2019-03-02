class Card

  if(ENV['DATABASE_URL'])
        uri = URI.parse(ENV['DATABASE_URL'])
        DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
    else
        DB = PG.connect(host: "localhost", port: 5432, dbname: 'baseball_backend_development')
    end

    def self.all
      results = DB.exec("SELECT * FROM card")
      return results.map do |result|
        {
          "id" => result["id"].to_i,
          "player" => result["player"],
          "team" => result["team"],
          "image" => result["image"],
          "position" => result["position"],
          "batting_avg" => result["batting_avg"],
          "card_owner" => result["card_owner"]
        }
      end #ends map do
    end #ends self all

    def self.find(id)
      results = DB.exec(
        <<-SQL
          SELECT
            card.*
          FROM card
          WHERE card.id=#{id}
        SQL
      )
      result = results.first
      return {
        "id" => result["id"].to_i,
        "player" => result["player"],
        "team" => result["team"],
        "image" => result["image"],
        "position" => result["position"],
        "batting_avg" => result["batting_avg"],
        "card_owner" => result["card_owner"]
      }
    end

    def self.create(opts)
      results = DB.exec(
        <<-SQL
          INSERT INTO card (player, team, image, position, batting_avg, card_owner)
          VALUES ('#{opts["player"]}', '#{opts["team"]}', '#{opts["image"]}', '#{opts["position"]}', #{opts["batting_avg"]}, '#{opts["card_owner"]}')
          RETURNING id, player, team, image, position, batting_avg, card_owner
        SQL
      )
      result = results.first
      return {
        "id" => result["id"].to_i,
        "player" => result["player"],
        "team" => result["team"],
        "image" => result["image"],
        "batting_avg" => result["batting_avg"],
        "card_owner" => result["card_owner"]
      }
    end

    def self.delete(id)
        results = DB.exec("DELETE FROM card WHERE id=#{id}")
        return { "DELETED" => true}
    end

    def self.update(id, opts)
      results = DB.exec(
        <<-SQL
          UPDATE card
          SET
            player='#{opts["player"]}',
            team='#{opts["team"]}',
            image='#{opts["image"]}',
            position='#{opts["position"]}',
            batting_avg=#{opts["batting_avg"]},
            card_owner='#{opts["card_owner"]}'
          WHERE id=#{id}
          RETURNING id, player, team, image, position, batting_avg, card_owner;
        SQL
      )
      return {
        "id" => results.first["id"].to_i,
        "player" => results.first["player"],
        "team" => results.first["team"],
        "image" => results.first["image"],
        "position" => results.first["position"],
        "batting_avg" => results.first["batting_avg"],
        "card_owner" => results.first["card_owner"]
      }
    end

end
