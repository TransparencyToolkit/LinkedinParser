class Picture
  def initialize(html)
    @html = html
  end
  
  # Get path to the picture url
  def picture
    @html.css('.profile-picture').css('img').first['src']
  end

  # Download picture
  def pic_path
    if picture
      # Get path
      dir = "pictures/"
      full_path = dir+picture.split("/").last.chomp.strip

      # Get file
      `wget -P #{dir} #{picture}` if !File.file?(full_path)
      delete_duplicate_pics
      return full_path
    end
  end

  # Deletes duplicate pictures
  def delete_duplicate_pics
    pics = Dir["public/uploads/pictures/*.jpg.*"]
    pics.each do |p|
      File.delete(p)
    end
  end
end
