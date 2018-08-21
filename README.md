# 📥 SendFoods 🍆

This is a simple rails app that connects to [Venmos's public transaction API](https://venmo.com/api/v5/public) and spits out trends.

By default, the app connects to the Venmo API every 5 minute and retrieves the latest 50 transactions. Then it parses the messages of those transactions, looking specifically for emoji. (You can change this request intervals/amounts. I changed it to this from 1 request/min because I noticed some throttling eventually starts happening.)

Once you run it, the database will start populating and you can see stats and recent examples. The index shows the top 10 emoji and but you can also look at daily trends by going to exampleurl.com/emoji/🍕. If you want to compare two emoji, you can go to exampleurl.com/compare?emoji_one=🍕&emoji_two=🍔.

### Limitations

Parsing emoji can be a bit challenging. Right now, the emoji parser uses [Emoji Data](https://github.com/mroth/emoji_data.rb), which uses an older version of the Unicode spec.
