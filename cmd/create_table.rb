module Cmd

  class CreateTable

    attr_accessor :tablename
    attr_accessor :conn
    attr_accessor :cols_hash
    
    attr_accessor :sql

    def initialize(vars)
      self.tablename = vars[:tablename]
      self.conn = vars[:conn]
      self.cols_hash = vars[:cols_hash]
    end

    def build_sql
      sql_cols = []
      self.cols_hash.each do |key, value|
        sql_cols << "\"#{key}\" \"#{value}\""
      end

      sql_cols_string = sql_cols.join(",")
      self.sql = "CREATE TEMPORARY TABLE #{self.tablename} (#{sql_cols_string})"
    end

    def execute
      build_sql
      puts self.sql
      res = self.conn.exec(self.sql)
      puts res.result_status
    end

  end

end