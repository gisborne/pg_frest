require 'pg'

module Frest
  @database = PG::Connection.new(
      dbname: 'frest_development'
  )

  def self.database
    @database
  end
end
