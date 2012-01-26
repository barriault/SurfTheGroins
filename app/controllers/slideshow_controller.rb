class SlideshowController < ApplicationController
  
  layout nil

  def index
    @album_id = CurrentSlideshow.find(1).album_id
    @slideshow = get_slideshow(@album_id)
  end
  
  private
  
  def get_slideshow(album_id)
    slideshow = Slideshow.new
    slideshow.slides = []

    smugmug = SmugMug.new(SURF_THE_GROINS_KEY)
    smugmug.login_anonymously
    
    album = smugmug.albums_get_info(album_id)["Album"]
    slideshow.title = album["Title"]
    slideshow.description = album["Description"]
    
    smugmug.images_get(album_id)["Images"].each do |image|
      urls = smugmug.images_get_urls(image["id"])["Image"]
      slide = Slide.new
      slide.image_m = urls["MediumURL"]
      slideshow.slides << slide
    end
    
    return slideshow
  end
  
end
