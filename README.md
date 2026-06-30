# TV2 Playlist

## Source

চ্যানেল list নেওয়া হয়েছে:

**https://raw.githubusercontent.com/abusaeeidx/Mrgify-BDIX-IPTV/refs/heads/main/playlist.m3u**

- Repo: [abusaeeidx/Mrgify-BDIX-IPTV](https://github.com/abusaeeidx/Mrgify-BDIX-IPTV)
- মূল playlist update হলে এখান থেকে আবার sync করতে হবে

## File

| File | ব্যবহার |
|------|---------|
| `playlist.m3u` | একমাত্র playlist — সব edit এখানেই |

## Categories

```
LIVE → News Channel → বাংলাদেশী চ্যানেল → Sports Channels
→ Kids → Entertainment Channels → Movie Channels → Infotainment
```

একই নামের একাধিক source থাকলে পাশাপাশি রাখা হয়।

## App-এ ব্যবহার

Git push করার পর raw URL দিয়ে load করো:

```
https://raw.githubusercontent.com/<user>/<repo>/main/playlist.m3u
```

## গুরুত্বপূর্ণ

- কিছু link-এ **token/expiry** থাকে — কিছুদিন পর কাজ বন্ধ হতে পারে
- Event/LIVE চ্যানেল (match, FIFA ইত্যাদি) স্থায়ী নয়
- Link test: `ffprobe` / `ffmpeg` দিয়ে manifest check, তারপর VLC বা Android TV-তে confirm
- Ping/HTTP 200 মানে stream চলবে — এটা guarantee নয়

## Update (manual)

1. উপরের source URL থেকে নতুন `playlist.m3u` দেখো
2. নতুন/বদলানো entry `playlist.m3u`-তে যোগ বা আপডেট করো
3. category ও same-name পাশাপাশি রাখার নিয়ম মেনে চলো
