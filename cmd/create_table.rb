require_relative '../log'

module Cmd

  class CreateTable

    attr_accessor :tablename
    attr_accessor :conn
    attr_accessor :cols_hash
    
    attr_accessor :sql

    include Log

    def initialize(vars)
      info("Initializing #{self.class.name} ...")

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
      self.sql = %{
        CREATE TEMPORARY TABLE #{self.tablename} (#{sql_cols_string})
      }

      info(self.sql)
    end

    def drop_if_exist
      info ("Dropping table '#{self.tablename}'...")
      res = self.conn.exec("DROP TABLE IF EXISTS #{self.tablename}")
      info ("Drop table return '#{res.res_status(res.result_status)}'")
    end

    def execute
      drop_if_exist
      build_sql
      res = self.conn.exec(self.sql)
      info("Executed return '#{res.res_status(res.result_status)}'")
    end

  end

end