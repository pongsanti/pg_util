require './cmd/create_table'
require './cmd/copy_csv'
require './cmd/migrate'

class Import

  attr_accessor :conn
  attr_accessor :schemaname
  attr_accessor :tmp_cols_hash
  attr_accessor :csv_file_path
  attr_accessor :src_cols
  attr_accessor :dest_tablename
  attr_accessor :dest_cols

  def initialize(vars)
    self.conn = vars[:conn]
    self.schemaname = vars[:schemaname]
    self.tmp_cols_hash = vars[:tmp_cols_hash]
    self.csv_file_path = vars[:csv_file_path]
    self.src_cols = vars[:src_cols]
    self.dest_tablename = vars[:dest_tablename]
    self.dest_cols = vars[:dest_cols]
  end

  def tmp_table_name
    "TEMP"
  end

  def table_name
    result = self.dest_tablename
    unless self.schemaname.to_s.empty?
      result = "#{self.schemaname}.#{result}"
    end

    return result
  end

  def execute
    Cmd::CreateTable.new(tablename: tmp_table_name, 
      cols_hash: self.tmp_cols_hash , conn: self.conn).execute

    Cmd::CopyCsv.new(filepath: self.csv_file_path, 
      tablename: tmp_table_name, conn: self.conn).execute

    Cmd::Migrate.new(conn: self.conn, 
      src_tablename: tmp_table_name, 
      src_cols: self.src_cols,
      dest_tablename: table_name, 
      dest_cols: self.dest_cols).execute
  end

end