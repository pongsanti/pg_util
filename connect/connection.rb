require 'pg'

module Connect
  class Connection

    attr_accessor :vars
    attr_accessor :get

    def initialize(conn_vars)
      self.vars = conn_vars
    end

    def connect
      self.get = PGconn.connect(self.vars[:host], self.vars[:port], '', '', self.vars[:dbname], self.vars[:user], self.vars[:pass])
      #res  = conn.exec('select tablename, tableowner from pg_tables')

      #res.each do |row|
      #  puts row['tablename'] + ' | ' + row['tableowner']
      #end
    end

  end
end