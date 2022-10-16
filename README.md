# ListenBlue
A music player written in Flutter for Linux. (GStreamer)



https://user-images.githubusercontent.com/44374434/196052980-925ab655-43b9-4e30-9726-b852f44f90fa.mp4



## Configuration
### `config.toml`
Example for `~/.config/listen_blue/config.toml`
```toml
collections = [
  "~/Music/music_files_1",
]

background_color = 0x7600000F

[[playlists]]
title = "My Cool Playlist"
ids = [
  "ding_orch",
  "raindrop_flower_ereve",
  "night_market_piano",
]
```

### Collections
A collection is a folder to bind metadata to mp3s
A folder structure for a collection may be:
```
music_files_1
| collection.toml
| ding_orch.mp3
| kikuin_date.jpeg
| night_market_piano.mp3
| paintamelody.png
| pinacoco.jpg
| raindrop_flower_ereve.mp3
```
And the `collection.toml` file will be:
```toml
[ding_orch]
title = "Dance in the Game [ORCHESTRAL]"
authors = [ "Kikuin Date" ]
squareImage = "kikuin_date.jpeg"

[raindrop_flower_ereve]
title = "Raindrop Flower (Ereve)"
authors = [ "Paintamelody" ]
squareImage = "paintamelody.png"

[night_market_piano]
title = "🍍Night Market - [Maplestory] - Piano Cover🥥"
authors = [ "PinaCoco" ]
squareImage = "pinacoco.jpg"
```
