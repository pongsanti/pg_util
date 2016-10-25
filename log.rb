require 'logger'

module Log

  def logger
    @logger ||= Logger.new(STDOUT)
  end

  def info(s)
    logger.info(s)
  end

end