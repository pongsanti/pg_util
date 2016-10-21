module Cmd
  
  class CopyCsv

    attr_accessor :filepath
    attr_accessor :tablename
    attr_accessor :header
    attr_accessor :conn

    attr_accessor :sql

    def initialize(vars)
      self.filepath = vars[:filepath]
      self.tablename = vars[:tablename]
      
      self.header = vars[:header]
      self.header ||= "HEADER"

      self.conn = vars[:conn]
    end

    def build_sql
      self.sql = "COPY #{self.tablename} FROM '#{self.filepath}' DELIMITER ',' CSV #{self.header}"
    end

    def execute
      build_sql
      puts self.sql
      res = self.conn.exec(self.sql)
      puts res.result_status
    end

  end

end