class AddFaviconToLabel < ActiveRecord::Migration
  def change
    add_attachment :labels, :favicon
  end
end
