class Architecture < ActiveRecord::Base

  has_and_belongs_to_many :repositories

  has_many :download_stats
  has_many :downloads

  has_many :flags
  has_many :build_flags
  has_many :publish_flags
  has_many :debuginfo_flags
  has_many :useforbuild_flags
  has_many :binarydownload_flags
  has_many :sourceaccess_flags
  has_many :privacy_flags
  has_many :access_flags


  def self.archcache
    return @cache if @cache
    @cache = Hash.new
    find(:all).each do |arch|
      @cache[arch.name] = arch
    end
    return @cache
  end

  def archcache
    self.class.archcache
  end

  def after_create
    logger.debug "updating arch cache (new arch '#{name}', id \##{id})"
    archcache[name] = self
  end

  def after_update
    logger.debug "updating arch cache (arch name for id \##{id} changed to '#{name}')"
    archcache.each do |k,v|
      if v.id == id
        archcache.delete k
        break
      end
    end
    archcache[name] = self
  end

  def after_destroy
    logger.debug "updating arch cache (arch '#{name}' deleted)"
    archcache.delete name
  end
end

