videos = [
  { title: 'first video', description: 'this is the first video that i make it myself', small_cover_url: '/tmp/family_guy.jpg', large_cover_url: '/tmp/monk_large.jpg' },
  { title: 'second video', description: 'this is the second video that i make it myself', small_cover_url: '/tmp/futurama.jpg', large_cover_url: '/tmp/monk_large.jpg' },
  { title: 'third video', description: 'this is the third video that i make it myself', small_cover_url: '/tmp/monk.jpg', large_cover_url: '/tmp/monk_large.jpg' },
  { title: 'fourth video', description: 'this is the fourth video that i make it myself', small_cover_url: '/tmp/south_park.jpg', large_cover_url: '/tmp/monk_large.jpg' }
]

videos.each do |attributes|
  Video.find_or_initialize_by(title: attributes[:title]).tap do |video|
    video.description = attributes[:description]
    video.small_cover_url = attributes[:small_cover_url]
    video.large_cover_url = attributes[:large_cover_url]
    video.save!
  end
end