module MessagesHelper

def find_name(emoji)
  unless (EmojiData.scan(emoji)[0].nil?)
    @capsname = EmojiData.scan(emoji)[0].name
    @capsname.downcase.split.map(&:capitalize).join(' ')
  else
    " "
  end

end

def emoji_exists(emoji)
  unless EmojiData.scan(emoji)[0].nil?
    true
  end
end

def trend_icon(num)
  #num == 1 ? "trending" : "not trending"
  if num == 1
    "fas fa-arrow-up"
  elsif num == -1
    "fas fa-arrow-down"

  end
end

def rand_emoji(num)

  every_emoji = EmojiData.all
  emoji_array = []
  while num > 0
    rando = Random.new.rand(0..844)
    emoji_array.push(every_emoji[rando].render)
    num = num - 1
  end
  emoji_array.uniq
end

def hour_ago
  @hourago = 1.hour.ago.getlocal
  formatted = @hourago.strftime("%l:%M %P")
  formatted
end

end
