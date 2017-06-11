require 'pg'

module Frest
  @database = PG::Connection.new(
      dbname: 'frest_development',
      user:   'anon'
  )

  def self.database
    @database
  end
end
