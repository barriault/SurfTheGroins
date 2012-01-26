require 'net/https'
require 'uri'
require 'json'

# A very simple API library for SmugMug. There is no error checking. This is a 
# very quick and dirty hack. Use it like so:
#
#   smugmug = SmugMug.new("YOUR-API-KEY")
#   session = smugmug.call("smugmug.login.anonymously")
#  
# NOTE: This will return a hash but the keys won't be symbols!
class SmugMug
  attr :api_key
  attr :session_id
  
  def initialize(api_key)
    @api_key = api_key
  end
  
  def login_anonymously()
    json = call("smugmug.login.anonymously")
    @session_id = json["Login"]["Session"]["id"]
    return json
  end
  
  def login_with_password(email_address, password)
    parameters = {}
    parameters[:EmailAddress] = email_address
    parameters[:Password] = password
    parameters[:APIKey] = api_key
    
    json = call_secure("smugmug.login.withPassword", parameters)
    @session_id = json["Login"]["Session"]["id"]
    return json
  end
  
  def logout()
    parameters = {}
    parameters[:APIKey] = api_key
    parameters[:SessionID] = session_id
    
    call("smugmug.logout", parameters)
  end
  
  def albums_get(nick_name = nil, heavy = nil, site_password = nil)
    parameters = {}
    parameters[:APIKey] = api_key
    parameters[:SessionID] = session_id
    parameters[:NickName] = nick_name if nick_name
    parameters[:Heavy] = heavy if heavy
    parameters[:SitePassword] = site_password if site_password
    
    call("smugmug.albums.get", parameters)
  end
  
  def albums_get_info(album_id, password = nil, site_password = nil)
    parameters = {}
    parameters[:APIKey] = api_key
    parameters[:SessionID] = session_id
    parameters[:AlbumID] = album_id
    parameters[:Password] = password if password
    parameters[:SitePassword] = site_password if site_password
    
    call("smugmug.albums.getInfo", parameters)
  end
  
  def images_get(album_id, heavy = nil, password = nil, site_password = nil)
    parameters = {}
    parameters[:APIKey] = api_key
    parameters[:SessionID] = session_id
    parameters[:AlbumID] = album_id
    parameters[:Heavy] = heavy if heavy
    parameters[:Password] = password if password
    parameters[:SitePassword] = site_password if site_password
    
    call("smugmug.images.get", parameters)
  end
  
  def images_get_urls(image_id, template_id = nil, password = nil, site_password = nil)
    parameters = {}
    parameters[:APIKey] = api_key
    parameters[:SessionID] = session_id
    parameters[:ImageID] = image_id
    parameters[:TemplateID] = template_id if template_id
    parameters[:Password] = password if password
    parameters[:SitePassword] = site_password if site_password
    
    call("smugmug.images.getURLs", parameters)
  end
  
  def images_get_info(image_id, password = nil, site_password = nil)
    parameters = {}
    parameters[:APIKey] = api_key
    parameters[:SessionID] = session_id
    parameters[:ImageID] = image_id
    parameters[:Password] = password if password
    parameters[:SitePassword] = site_password if site_password
    
    call("smugmug.images.getInfo", parameters)
  end
  
  private

  def call(method, params = {})
    parameters = params.dup
    parameters[:method] = method
    parameters[:APIKey] = api_key
    
    response = http.get(path_for_params(parameters))
    json = JSON.parse(response.body)
  end

  def call_secure(method, params = {})
    parameters = params.dup
    parameters[:method] = method
    parameters[:APIKey] = api_key
    
    url = URI.parse('https://api.smugmug.com/index.html')
    response = Net::HTTP.start(url.host, url.port) {|https|
      https.get(path_for_params(parameters))
    }
    puts(response.body)
  end

  def path_for_params(params)
    query_string = query_string = "?" + params.inject([]) { |qs, pair| qs << "#{CGI.escape(pair[0].to_s)}=#{CGI.escape(pair[1].to_s)}"; qs }.join("&")
    "/hack/json/1.2.0/" + query_string
  end

  def http
    @http ||= Net::HTTP.new("api.smugmug.com", 80)
  end
  
end