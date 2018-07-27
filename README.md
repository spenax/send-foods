# README

This is a simple rails app that connects to [Venmos's public transaction API](https://venmo.com/api/v5/public).

By default, the app connects to API every minute and retrieves the latest 20 transactions. Then it parses the messages of those transactions, looking specifically for emoji.

Once you run it, the database will start populating and you can see stats. The index shows the top 10 emoji and but you can also look at daily trends by going to exampleurl.com/🍕.

### Limitations

Emoji are tough. Right now, the emoji parser uses [Emoji Data](https://github.com/mroth/emoji_data.rb), which currently only supports an older version of the Unicode spec.
