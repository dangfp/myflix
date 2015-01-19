commedies = Category.create(name: 'TV Commedies')
dramas = Category.create(name: 'TV Dramas')

videos = [
  { title: 'family_guy', description: 'this is the first video that i make it myself', small_cover_url: '/tmp/family_guy.jpg', large_cover_url: '/tmp/monk_large.jpg', category: commedies },
  { title: 'futurama', description: 'this is the second video that i make it myself', small_cover_url: '/tmp/futurama.jpg', large_cover_url: '/tmp/monk_large.jpg', category: commedies },
  { title: 'monk', description: 'this is the third video that i make it myself', small_cover_url: '/tmp/monk.jpg', large_cover_url: '/tmp/monk_large.jpg', category: commedies },
  { title: 'south_park', description: 'this is the fourth video that i make it myself', small_cover_url: '/tmp/south_park.jpg', large_cover_url: '/tmp/monk_large.jpg', category: commedies },
  { title: 'family_guy2', description: 'this is the first video that i make it myself', small_cover_url: '/tmp/family_guy.jpg', large_cover_url: '/tmp/monk_large.jpg', category: commedies },
  { title: 'futurama2', description: 'this is the second video that i make it myself', small_cover_url: '/tmp/futurama.jpg', large_cover_url: '/tmp/monk_large.jpg', category: commedies },
  { title: 'monk2', description: 'this is the third video that i make it myself', small_cover_url: '/tmp/monk.jpg', large_cover_url: '/tmp/monk_large.jpg', category: commedies },
  { title: 'south_park2', description: 'this is the fourth video that i make it myself', small_cover_url: '/tmp/south_park.jpg', large_cover_url: '/tmp/monk_large.jpg', category: dramas }
]

videos.each do |attributes|
  Video.find_or_initialize_by(title: attributes[:title]).tap do |video|
    video.description = attributes[:description]
    video.small_cover_url = attributes[:small_cover_url]
    video.large_cover_url = attributes[:large_cover_url]
    video.category = attributes[:category]
    video.save!
  end
end