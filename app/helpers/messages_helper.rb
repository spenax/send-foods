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

def trend_word(num)
  num == 1 ? "trending" : "not trending"
  if num == 1
    "blowing up"
  elsif num == -1
    "petering out"

  end
end

def hour_ago
  @hourago = 1.hour.ago.getlocal
  formatted = @hourago.strftime("%l:%M %P")
  formatted
end

end
