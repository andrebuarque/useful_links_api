class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.string :title
      t.string :url
      t.belongs_to :category, :index => true

      t.timestamps
    end

    create_table :links_tags do |t|
      t.belongs_to :link, :index => true
      t.belongs_to :tag, :index => true
    end
  end
end
