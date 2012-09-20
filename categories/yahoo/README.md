## Yahoo Local Category Download

First install the Mozrepl plugin into Firefox
https://addons.mozilla.org/en-us/firefox/addon/mozlab/

Next you need the MozRepl library from cpan
```
perl -MCPAN -eshell
cpan> install MozRepl
```

Go to submit your business on Yahoo Local.
http://beta.listings.local.yahoo.com/signup/create_1.php?type=fl

With your browser open here just run request.pl and the category JSON
is saved into ./cats

Next run ./parse.sh

Fianlly, run:
rake yahoo:categories
to import categories.
