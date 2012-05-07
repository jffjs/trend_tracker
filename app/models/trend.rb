class Trend < ActiveRecord::Base
  belongs_to :user
  validates :query, presence: true
  geocoded_by :location

  after_validation :geocode

  def tweets
    # only want to load tweets once per page
    # this prevents us from searching every time this method is called for the
    # lifetime of the object
    if @tweets.nil?
      options = {}

      options[:geocode] = "#{latitude},#{longitude},50mi" if latitude && longitude
      options[:since_id] = last_tweet if last_tweet

      @tweets = Twitter.search(query, options)

      # set the last tweet so we know where to search from next time
      if @tweets.size > 0
        self.last_tweet = @tweets.first.id
        self.save
      end
    end

    return @tweets
  end
end
