
Challenge accepted.  Some of the most used scripts do a small task well.  I propose to keep it simple and write something that will help the user figure out what's in range and what they have. So I'm going to call the script "What's for lunch?" or "wfl"

I tend to write scripts by testing as I go.  Each line, or group of lines will be put through the paces as it gets written.  I find this delivers stable code and the debugging process is minimal. After all, if you only changed a few lines of code, that's going to be where the problem is, right?  We will start with reading the csv file and go from there.

Initially, the script should list only trucks that are nearby. I will use zip code for the initial version. But we should think about ways to improve that, probably enter lat/long and a distance to locate trucks in range, probably +/- the known lat/long (a square), upgrade to a circle?

Initial steps: 

1) read the csv

2) read the csv and split the fields into individual elements

3) translate those elements into a data structure, probably an array of hash elements, or a hash of hashes keyed off an unique key (if there is one). Another possibility is to create a class object for each line and turn the array of lines into an array of objects

4) select array elements that meet selected criteria

5) output select fields that meet the criteria

note: The first line of the csv is the headerlist --- it would make sense to use those values as the hash keys and would add flexibility if the csv were to change.

Notes:
-----

- I don't see anything that is guaranteed to be an unique ID for the vendors on this list. Anything that is unique today, may not be unique tomorrow.  Location ID does not preclude more than one vendor at a given location.  If we learn that a permit is issued to each vendor for each truck/cart/other, then perhaps we could use that.  For now, I have to assume that one permit may map to multiple vehicles

- I'm so rusty, it just occurred to me that I need to concern myself with scoping rules.  Some of the data should be global, but making the rest local with 'my' is a very good idea

- the data I'm getting for my last line does not match up with the last line in the csv. Either I have a bug, or the data has an issue that I don't know about

- finding the csv I downloaded does not match the csv in github.  Created a short one for testing

- having issues pushing a hash onto an array.. definitely need to review ;) Solved: the array of hashes needs to be built with anonymous hashes.  Once I reviewed the example in the book, this was obvious.

- I would like to add a utility to specify the fields I would like to print out.  We can parse a list of fields provided on the command line as an argument to a flag and use that to specify the fields.  But fields currently have whitespace in them which is problematic.  So it would make sense to "normalize them" by replacing space with an underscore
	- so we can read the first line to get the list of fields, massage them to trim off leading and trailing whitespace, turn internal whitespace into underscores, and print that out.  Then we can list them out to the user with the right flag.  The user can provide the list of fields he wishes to see as an argument to a flag.

- Yesterday, I noticed that there are inconsistencies in the data. For example, the zip codes are not all there, some are incorrect.  It's important not to assume the data is correct until you've confirmed it is.  This points to a need to find the bad data and correct it.  Generating a list of problem data becomes a priority so that it can be fixed.  Perhaps a campaign to "help customers find you" by correcting your information.



------------------------------------------------------------------------------------------
# Engineering Challenge

We strive to be a practical and pragmatic team here at Estee Lauder Companies. That extends to the way that we work with you to understand if this team is a great fit for you. We want you to come away with a great understanding of the kind of things that we actually do day to day and what it is like to work in our teams.

We don't believe that whiteboard coding with someone watching over your shoulder accurately reflects our day to day. Instead we'd like to be able to discuss code that you have already written when we meet.

This can be a project of your own or a substantial pull request on an open source project, but we recognize that most people have done private or proprietary work and this engineering challenge is for you.

We realize that taking on this assignment represents a time commitment for you, and we do not take that lightly. Throughout the recruitment process we will be respectful of your time and commit to working quickly and efficiently. This will be the only technical assessment you'll be asked to do. The brief following conversations will be based on this assessment and your prior experiences.

## Challenge Guidelines

* This is meant to be an assignment that you spend approximately two to three hours of focused coding. Do not feel that you need to spend extra time to make a good impression. Smaller amounts of high quality code will let us have a much better conversation than large amounts of low quality code.

* Think of this like an open source project. Create a repo on Github, use git for source control, and use a Readme file to document what you built for the newcomer to your project.

* We build systems engineered to run in production. Given this, please organize, design, test, deploy, and document your solution as if you were going to put it into production. We completely understand this might mean you can't do much in the time budget. Prioritize production-readiness over features.

* Think out loud in your documentation. Write our tradeoffs, the thoughts behind your choices, or things you would do or do differently if you were able to spend more time on the project or do it a second time.

* We have a variety of languages and frameworks that we use at Estee Lauder Companies, but we don't expect you to know them ahead of time. For this assignment you can make whatever choices that let you express the best solution to the problem given your knowledge and favorite tools without any restriction. Please make sure to document how to get started with your solution in terms of setup so that we'd be able to run it.

* Once this is functioning and documented to your liking, either send us a link to your public repo or compress the project directory, give the file a pithy name which includes your own name, and send the file to us.

## The Challenge

As the song says, "you've got to play the hand you're dealt", and in this case your hand is to implement something to help us manage our food truck habit.

Our team loves to eat. They are also a team that loves variety, so they also like to discover new places to eat.

In fact, we have a particular affection for food trucks. One of the great things about Food Trucks in San Francisco is that the city releases a list of them as open data.

Your assignment is to make it possible for our teams to do something interesting with this food trucks data.

This is a freeform assignment. You can write a web API that returns a set of food trucks. You can write a web frontend that visualizes the nearby food trucks for a given place. You can create a CLI that lets us get the names of all the taco trucks in the city. You can create system that spits out a container with a placeholder webpage featuring the name of each food truck to help their marketing efforts. You're not limited by these ideas at all, but hopefully those are enough help spark your own creativity.
San Francisco's food truck open dataset is [located here](https://data.sfgov.org/Economy-and-Community/Mobile-Food-Facility-Permit/rqzj-sfat/data) and there is an endpoint with a [CSV dump of the latest data here](https://data.sfgov.org/api/views/rqzj-sfat/rows.csv). We've also included a copy of the data in this repo as well.
