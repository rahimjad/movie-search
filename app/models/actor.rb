class Actor < ApplicationRecord
  has_many :movie_actors
  has_many :movies, :through => :movie_actors

  def co_actors 
    # Personal preference to use pure SQL queries for more complex relationships
    # as it is easier to read IMO. Eventually more complex queries can be extracted
    # as fixtures. I chose this approach over Scopes, however I know this could easily
    # be a scope
    sql = <<~SQL
      SELECT actor_id, count(*) movie_count 
      FROM movie_actors
      WHERE movie_id IN (SELECT movie_id FROM movie_actors WHERE actor_id = ?)
      AND actor_id != ?
      GROUP BY actor_id
      ORDER BY movie_count desc
      LIMIT 5
    SQL

    sanitized_sql = ActiveRecord::Base.sanitize_sql([sql, id, id])
    top_5 = ActiveRecord::Base.connection.execute(sanitized_sql)

    # This could all be done in one SQL request, I decided to split it up so we can
    # actually extract ActiveRecord models. If we needed more Actors or if the data set were 
    # larger I'd do it in one query
    Actor.where(id: top_5.map { |r| r['actor_id'] })
  end
end
