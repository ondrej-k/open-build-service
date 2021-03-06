# ==============================================================================
# 
#
class ProjectRawConfigPage < ProjectPage


  # ============================================================================
  # (see WebPage#validate_page)
  #
  def validate_page
    super
    validate { @driver.page_source.include? "Meta Configuration of " + @project }
  end
  

  # ============================================================================
  # (see WebPage#initialize)
  #
  def initialize web_driver, options={}
    super
    @url = $data[:url] + "/project/meta?project=" + CGI.escape(@project)
  end
  

  # ============================================================================
  # (see WebPage#initialize_ready)
  #
  def initialize_ready web_driver
    super
    @url = $data[:url] + "/project/meta?project=" + CGI.escape(@project)
  end
  
end
