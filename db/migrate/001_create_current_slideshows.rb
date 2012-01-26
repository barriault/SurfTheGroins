class CreateCurrentSlideshows < ActiveRecord::Migration
  def self.up
    create_table :current_slideshows do |t|
      t.column :album_id, :string
    end
    
    CurrentSlideshow.create(:album_id => 3575691)
  end

  def self.down
    drop_table :current_slideshows
  end
end
