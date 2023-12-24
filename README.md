# aoc2023

![](https://img.shields.io/badge/day%20📅-24-blue)
![](https://img.shields.io/badge/stars%20⭐-19-yellow)
![](https://img.shields.io/badge/days%20completed-9-red)

Once again trying Elixir! We'll see how this goes...

## day 1
Did this one flying back from a very abreviated trip to Seattle, so I was sleepy and working with fairly slow internet. I was caught by the `threeight` corner case in part 2 and was already so invested in not using regex that I just inserted `three3three` for every `three` and such. I did consider looking at the string backwards, but what I didn't consider was that I only needed the first and last occurrences so my hacky method was overcomplicating things. Would've worked if we needed all numbers in the string, though!

## day 2
Fairly happy with my approach here. I gave into using regex and was able to create a solid foundation with the `max_for_color` function. From there, it was just a matter of creating the map or list structure I needed and reducing the values from there.

## day 3
This feels super messy, and I'm sure there's a simpler solution here that I'm missing. Similarly to day 2, I build somewhat of a solid foundation by regex-ing symbols and numbers and putting those in a list then parsing it within a 3 row window. I probably could clean some of this up, like make `parse_rows` more general so I can identify which symbols are gears and do the min/max calculations while parsing the rows to avoid duplicate work. The stacking `reduce`s also breaks my brain, but that seems to be the most elixir-y route here.

\* Note: I ended up cleaning up the `parse_rows` and min/max calculations a bit. Next thing I could do is make `parse_rows` slightly less verbose.

## day 4
Feeling more comfortable with Elixir! I'm sure my code still looks like chaos, but I'm getting more used to pattern matching and the scope that things are updated.

## day 5
It's starting to get tricky 😅 While reading the second part, I definitely thought "oh cool, I can use my previous solution!" (Narrator: she couldn't). At least the work I did to create the list of numbers didn't go to waste as I could use the first half of the pipeline to still create the ranges and process those. After that, it was just processing the ranges in batches. It feels messy, so I'm sure there are cleaner solutions out there but I'm not too mad at this one.

## day 6
I was so excited when I realized IT'S A QUADRATIC. Apparently you could've brute forced it but I'm still proud 😅.

## day 7
Not as bad as I expected! I saw poker and panicked, but wasn't too bad. Wildcards were far simpler than I thought they would be.

## day 8
Day 8 was a challenge! I had a lot of trouble seeing that it was effectively a LCM problem and even when I did, digging up the recollection of the algorithm (and how to do it for multiple numbers) was a struggle (Sorry, Ms. Baker! At least I remembered the quadratic formula!). Really glad to have done it though and have an excuse to refresh the basics!

## day 9
I have a busy day ahead of me so I got up early to do this. I was fairly surprised that it was so straight-forward but definitely grateful I won't be spinning my wheels about this for the rest of the day!
