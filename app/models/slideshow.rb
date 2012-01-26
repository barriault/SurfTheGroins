class Slideshow < ActionWebService::Struct
  
  member :title, :string
  member :description, :string
  member :url, :string
  member :slides, [Slide]
  
  def get_slides_array
    result = ""
    slides.each_index do |i|
      result << ", " if i != 0
      result << "\'slide#{i}\'"
    end
    return result
  end
  
end