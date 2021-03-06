require_relative '../log'

module Cmd

  class Migrate

    attr_accessor :src_tablename
    attr_accessor :src_cols
    attr_accessor :dest_tablename
    attr_accessor :dest_cols
    attr_accessor :conn

    attr_accessor :sql

    include Log

    def initialize(vars)
      info("Initializing #{self.class.name} ...")

      self.src_tablename = vars[:src_tablename]
      self.src_cols = vars[:src_cols]
      self.dest_tablename = vars[:dest_tablename]
      self.dest_cols = vars[:dest_cols]
      self.conn = vars[:conn]
    end

    def build_sql
      src_cols_string = self.src_cols.join(",")
      dest_cols_string = self.dest_cols.join(",")

      self.sql = %{
        INSERT INTO #{self.dest_tablename} (#{dest_cols_string})
        SELECT #{src_cols_string}
        FROM #{self.src_tablename}
      }

      info(self.sql)
    end

    def execute
      build_sql
      res = self.conn.exec(self.sql)
      info("Executed return '#{res.res_status(res.result_status)}'")
    end    

  end

end