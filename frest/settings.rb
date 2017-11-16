require 'pg'

module Frest
  @database = PG::Connection.new(
      dbname: 'frest_development',
      user:   'anon',
      password: '9455word'
  )

  @database.set_error_verbosity PG::Constants::PQERRORS_VERBOSE

  def self.database
    @database
  end

  def self.new_connection
    @database.dup
  end
end
