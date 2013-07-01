class AddTsvToForumsPosts < ActiveRecord::Migration
  def up
    add_column :forums_posts, :tsv, :tsvector
    execute <<-SQL
      CREATE OR REPLACE FUNCTION post_tsv_trigger() RETURNS trigger AS $$
        BEGIN
          new.tsv := to_tsvector('english', coalesce(new.text, '')) || 
          (SELECT to_tsvector('english', coalesce(forums_topics.subject, ' ')) FROM forums_topics WHERE forums_topics.id = new.topic_id);
          return new;
        END
      $$ LANGUAGE plpgsql;

      DROP TRIGGER IF EXISTS tsvectorupdate ON forums_posts;
      CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE ON forums_posts FOR EACH ROW EXECUTE PROCEDURE post_tsv_trigger();

      UPDATE forums_posts SET id = id;
    SQL
  end
  
  def down
    remove_column :forums_posts, :tsv
    execute <<-SQL
      DROP TRIGGER IF EXISTS tsvectorupdate ON forums_posts;
    SQL
  end
end
