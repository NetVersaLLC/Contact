Paste in the headers from a open session logged in to
http://www.google.com/local/add/details

Then run ./get_all.sh which downloads queries into ./cats

Next run $ node parse.js > final_list.js

This will generate the final hash of ids to names json. Finally run
rake categories:google

This will import Google categories.
