class AddTaggingsCountToTags < ActiveRecord::Migration
  def self.up
    add_column :tags, :taggings_count, :integer, :default => 0

    Tag.reset_column_information
    Tag.all.each do |t|
      Tag.update_counters t.id, :taggings_count => t.taggings.length
    end
  end

  def self.down
    remove_column :tags, :taggings_count
  end
end
