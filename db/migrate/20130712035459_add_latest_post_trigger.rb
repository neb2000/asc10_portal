class AddLatestPostTrigger < ActiveRecord::Migration
  def change
    add_column :forums_boards, :latest_post_id, :integer
    add_index :forums_boards, :latest_post_id
    
    add_column :forums_posts, :board_id, :integer
    add_index :forums_posts, :board_id
    
    Forums::Post.includes(:topic).find_each do |post|
      post.board_id = post.topic.board_id
      post.save validate: false
    end
    
    execute <<-SQL
      CREATE OR REPLACE FUNCTION latest_post_trigger_before() RETURNS trigger AS $$
        BEGIN
          UPDATE forums_boards SET latest_post_id = (SELECT forums_posts.id FROM forums_posts WHERE forums_posts.board_id = new.board_id ORDER BY forums_posts.created_at DESC LIMIT 1)
          WHERE forums_boards.id = new.board_id;
          return new;
        END
      $$ LANGUAGE plpgsql;
    
      CREATE OR REPLACE FUNCTION latest_post_trigger_after() RETURNS trigger AS $$
        BEGIN
          UPDATE forums_boards SET latest_post_id = (SELECT forums_posts.id FROM forums_posts WHERE forums_posts.board_id = old.board_id ORDER BY forums_posts.created_at DESC LIMIT 1)
            WHERE forums_boards.id = old.board_id;
          return old;
        END
      $$ LANGUAGE plpgsql;
        
      DROP TRIGGER IF EXISTS updateboard_insert ON forums_posts;
      DROP TRIGGER IF EXISTS updateboard_update ON forums_posts;
      DROP TRIGGER IF EXISTS updateboard_delete ON forums_posts;
      
      CREATE TRIGGER updateboard_insert AFTER INSERT ON forums_posts FOR EACH ROW EXECUTE PROCEDURE latest_post_trigger_before();
      CREATE TRIGGER updateboard_update AFTER UPDATE ON forums_posts FOR EACH ROW EXECUTE PROCEDURE latest_post_trigger_after();
      CREATE TRIGGER updateboard_delete AFTER DELETE ON forums_posts FOR EACH ROW EXECUTE PROCEDURE latest_post_trigger_after();
    
      UPDATE forums_posts SET id = id;
    SQL
    
  end
end