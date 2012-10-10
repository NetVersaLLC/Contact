# Yelp

Yelp puts their categories in a convenient JSON file at:
https://biz.yelp.com/category_tree_json?country=US

Just run ./request.sh

Then the categories can be imported using:

rake yelp:load_categories
