require_relative '../log'

module Cmd
  
  class CopyCsv

    attr_accessor :filepath
    attr_accessor :tablename
    attr_accessor :header
    attr_accessor :conn

    attr_accessor :sql

    include Log

    def initialize(vars)
      info("Initializing #{self.class.name} ...")

      self.filepath = vars[:filepath]
      self.tablename = vars[:tablename]
      
      self.header = vars[:header]
      self.header ||= "HEADER"

      self.conn = vars[:conn]
    end

    def build_sql
      self.sql = %{
        COPY #{self.tablename} FROM '#{self.filepath}' DELIMITER ',' CSV #{self.header}
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