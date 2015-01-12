# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Video.create(title: "CSI",
 small_cover_url: "/public/tmp/monk.jpg",
 large_cover_url: "/public/tmp/monk_large.jpg",
 description: "由Gil Grissom领导的拉斯维加斯警局犯罪鉴证科夜班组的任务是深入案发现场寻找种种蛛丝马迹，并利用最先进的科技手段，把表面上没有任何联系、没有意义的线索拼凑成不可辩驳的证据，抽丝剥茧重组案情，让犯罪分子无处可逃……")