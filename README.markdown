# NinjaSearch

A widget-app designed for Cocoa apps/TextMate bundles to search through 
filename/functions/item titles and/or item descriptions of a list of items.

In one way it is a generic search dialog/window akin to TextMate's "Go to file" or 
"Find Bundle Item" dialogs, which live filtering of results and the characters 
entered by the user are matched against item partial names. E.g. if the user searches
for "nise" then matching items could include "NinjaSearch" or "ninja search" or 
"ninja-search" or "Ninja_Search". In each case "ninja" and "search" are partials
of each title, and the "nise" search string matches to starting letters of each partial.

NinjaSearch will also return results where the search string has matches against
an optional description string for each item being filtered against. So a search
string of "nise death" could match against the various "NinjaSearch" items as above
but further filtered by items whose description field includes the word "death". 
Or any items with descriptions including the words "nise" and "death"; if "nise" 
were a word in your language. Its not in mine, but you get the jist.

Each item in the list that is filtered to be visiable (e.g. any of the 
"NinjaSearch" items above) is displayed in a list, which its title and optional
description. For each matching item, the characters of the search string that match
to the title/description are highlighted/bolded.

One item from the visible list can be selected, subsequently closing the NinjaSearch
app and returning the item information as text to STDOUT.

The original list data is passed to NinjaSearch via STDIN.

## Limitations

* NinjaSearch is only available on OS X 10.4+ (due to NSSearchField)
* Um, it doesn't work yet. Its just an idea and a nib.

