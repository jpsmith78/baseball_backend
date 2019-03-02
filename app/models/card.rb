class Card

  DB = PG.connect({
    :host =>'localhost',
    :port =>5432,
    :dbname =>"baseball_backend_development"
    })

    def self.all
      results = DB.exec("SELECT * FROM card")
      return results.map do |result|
        {
          "id" => result["id"].to_i,
          "player" => result["player"],
          "team" => result["team"],
          "image" => result["image"],
          "position" => result["position"],
          "batting_avg" => result["batting_avg"].to_i,
          "card_owner" => result["card_owner"]
        }
      end #ends map do
    end #ends self all

end
