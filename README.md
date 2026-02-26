# Reddit AutoSub

An AutoHotKey v2 script to automate batch subscription to subreddits.

- Configurable variables
- Accepts a single-column CSV list of subreddits
- Tooltip displays current progress in list
- Checks if user is already a member of the subreddit before joining
- Pause, resume, and exit hotkeys
- Script exits on completion

**NOTE** This script will **NOT** work:
- while using old.reddit.com
- if you are in a country where Reddit requires ID verification
- on NSFW subreddits if you have not previously confirmed your account is over 18 (this is done on the account's initial visit to any NSFW subreddit)

## Hotkeys

- Pause / Resume script - Win+F10
- Exit script - Win+F12 

## Configuration

1. Export a list of subreddits from an existing reddit account (see below)
2. Set the variables at the beginning of the script (TABS_TO_JOIN is the number of times the Tab key must be entered until the subreddit "Join" button is selected)

### Export a list of subscribed subreddits

While logged into an account, navigate to [old.reddit.com/subreddits/mine](https://old.reddit.com/subreddits/mine) and enter the following in the browser console:
```
(() => {
  const list = $('.subscription-box')
    .find('a.title')
    .slice(1)
    .map((_, d) => $(d).attr('href')
      .replace(/^https?:\/\/(old\.)?reddit\.com\/r\//,'')
      .replace(/\/$/,'')
    )
    .get()
    .join("\n");

  document.body.innerText = list;
})();
```
This will give you a list you can copy to a CSV.