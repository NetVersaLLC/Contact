# script to combing all the client_data subclasses into one table using singke table inheritence 
#
# These classes can probalby be removed altogether 
#    bizzspot, brownbook, byzlysts, citydata, citysearch*, craigslist (no data table) 
#    crunchbase*, cylex, jayde, judys_book, mydestinations, onlinenetworks, spotbusiness (spotbusiness_Category), 
#    superpages

insert into client_data(business_id, email, secrets, status, force_update, listing_url, created_at, updated_at, category_id, do_not_sync, type) select business_id, email, secrets, status, force_update, listing_url, created_at, updated_at, angies_list_category_id, do_not_sync, "AngiesList" from angies_lists;
insert into client_data(business_id, force_update, secrets, username, created_at, updated_at, do_not_sync, type) select business_id, force_update, secrets, username, created_at, updated_at, do_not_sync, "Aol" from aols;
insert into client_data(business_id, local_url, email, secrets, status, force_update, created_at, updated_at, category_id, do_not_sync, type) select business_id, local_url, email, secrets, status, force_update, created_at, updated_at, bing_category_id, do_not_sync, "Bing" from bings; 
insert into client_data(business_id, created_at, updated_at, secrets, do_not_sync, force_update, email, username, type ) select business_id, created_at, updated_at, secrets, do_not_sync, force_update, email, username, "Bizzspot" from bizzspots;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, email, type) select business_id, created_at, updated_at, secrets, force_update, email, "Brownbook" from brownbooks; 
insert into client_data(business_id, created_at, updated_at, secrets, force_update, email, type) select business_id, created_at, updated_at, secrets, force_update, email, "Businesscom" from businesscoms; 
insert into client_data(business_id, created_at, updated_at, secrets, force_update, email, category_id, type) select business_id, created_at, updated_at, secrets, force_update, email, businessdb_category_id, "Businessdb" from businessdbs; 
insert into client_data(business_id, created_at, updated_at, secrets, force_update, email, do_not_sync, category_id, type) select business_id, created_at, updated_at, secrets, force_update, email, do_not_sync, citisquare_category_id, "Citisquare" from citisquares;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, email, do_not_sync, category_id, type) select business_id, created_at, updated_at, secrets, force_update, email, do_not_sync, citydata_category_id, "Citydata" from citydata;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, username, do_not_sync, category_id, type) select business_id, created_at, updated_at, secrets, force_update, username, do_not_sync, cornerstonesworld_category_id, "Cornerstonesworld" from cornerstonesworlds;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, email, facebook_signin, listing_url, type) select business_id, created_at, updated_at, secrets, force_update, email, facebook_signin, listing_url, "Citysearch" from citysearches;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, email, do_not_sync, category_id, type) select business_id, created_at, updated_at, secrets, force_update, email, do_not_sync, digabusiness_category_id, "Digabusiness" from digabusinesses; 
insert into client_data(business_id, created_at, updated_at, secrets, force_update, email, do_not_sync, type) select business_id, created_at, updated_at, secrets, force_update, email, do_not_sync, "Discoverourtown" from discoverourtowns; 
insert into client_data(business_id, created_at, updated_at, secrets, force_update, username, do_not_sync, category_id, type) select business_id, created_at, updated_at, secrets, force_update, username, do_not_sync, ebusinesspage_category_id, "Ebusinesspage" from ebusinesspages;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, category_id, type) select business_id, created_at, updated_at, secrets, force_update, expertfocus_category_id, "Expertfocus" from expertfocus;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username,  "Expressbusinessdirectories" from  expressbusinessdirectories;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, email, category_id, type) select business_id, created_at, updated_at, secrets, force_update, email, expressupdateusa_category_id, "Expressupdateusa" from expressupdateusas;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, ezlocal_category_id, "Ezlocal" from ezlocals;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, status, email, category_id, profile_category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, status, email, facebook_category_id, facebook_profile_category_id, "Facebook" from facebooks;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, status, email, facebook_signin, foursquare_page, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, status, email, facebook_signin, foursquare_page, foursquare_category_id, "Foursquare" from foursquares;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, "Freebusinessdirectory" from freebusinessdirectories;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, "Getfave" from getfaves;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, gomylocal_category_id, "Gomylocal" from gomylocals;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, youtube_channel, places_url, cookies, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, youtube_channel, places_url, cookies, google_category_id, "Google" from googles;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, status, listing_url, email, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, status, listing_url, email, "Hotfrog" from hotfrogs; 
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, hyplo_category_id, "Hyplo" from hyplos;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, ibegin_category_id, "Ibegin" from ibegins;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, listing_url, facebook_signin, status, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, listing_url, facebook_signin, status,insider_page_category_id, "InsiderPage" from insider_pages;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, type) select business_id, created_at, updated_at, secrets, force_update, "Jayde" from jaydes;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, email, listing_url, facebook_signin, status, type) select business_id, created_at, updated_at, secrets, force_update, email, listing_url, facebook_signin, status, "JudysBook" from judys_books;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, email, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, email, "Justclicklocal" from justclicklocals;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, status, listing_url, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, status, listing_url, kudzu_category_id, "Kudzu" from kudzus; 
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, "Linkedin" from linkedins; 
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, "Listwns" from listwns;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, localcensus_category_id, "Localcensus" from localcensus;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, "Localcom" from localcoms;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, localdatabase_category_id, "Localdatabase" from localdatabases;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, localeze_category_id, "Localeze" from localezes;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, localizedbiz_category_id, "Localizedbiz" from localizedbizs;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, "Localndex" from localndexes;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, localpages_category_id, "Localpage" from localpages;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, magicyellow_category_id, "Magicyellow" from magicyellows;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, "Manta" from manta;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, "MapQuest" from map_quests;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, "Matchpoint" from matchpoints;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, email, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, email, meetlocalbiz_category_id, "Meetlocalbiz" from meetlocalbiz;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, merchantcircle_category_id, "Merchantcircle" from merchantcircles;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, mojopages_category_id, "Mojopages" from mojopages;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, "Mycitybusiness" from mycitybusinesses;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, username, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, username, "Mywebyellow" from mywebyellows;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, primeplace_category_id, "Primeplace" from primeplaces;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, shopcity_category_id, "Shopcity" from shopcities;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, shopinusa_category_id, "Shopinusa" from Shopinusas;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, showmelocal_category_id, "Showmelocal" from showmelocals;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, snoopitnow_category_id, "Snoopitnow" from snoopitnows;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, staylocal_category_id, "Staylocal" from staylocals;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, supermedia_category_id, "Supermedia" from supermedia;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, email, type) select business_id, created_at, updated_at, secrets, force_update, email, "Superpages" from superpages;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, "Thinklocal" from thinklocals;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, "thumbtacks" from thumbtacks;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, username, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, username, tupalo_category_id, "Tupalo" from tupalos;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, twitter_page, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, twitter_page, "Twitter" from twitters;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, usbdn_category_id, "Usbdn" from usbdns;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, uscity_category_id, "Uscity" from uscities;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, usyellowpages_category_id, "Usyellowpages" from usyellowpages;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, yahoo_category_id, "Yahoo" from yahoos;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, "YellowBot" from yellow_bots;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, secret_answer, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, secret_answer, yellowassistance_category_id, "Yellowassistance" from yellowassistances;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, yellowee_category_id, "Yellowee" from yellowees;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, yellowise_category_id, "Yellowise" from yellowises;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, email, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, email, yellowtalk_category_id, "Yellowtalk" from yellowtalks;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, email, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, email, "Yellowwiz" from yellowwizs;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, yelp_category_id, "Yelp" from yelps;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, yippie_category_id, "Yippie" from yippies;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, ziplocal_category_id, "Ziplocal" from ziplocals;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, zipperpage_category_id, "Zipperpage" from zipperpages;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, category_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, email, zipperpage_category_id, "Zipperpage" from zipperpages;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, category_id, category2_id, type) select business_id, created_at, updated_at, secrets, force_update, do_not_sync, username, zippro_category_id, zippro_category2_id, "Zippro" from zippros;

