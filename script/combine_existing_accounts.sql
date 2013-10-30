# script to combing all the client_data subclasses into one table using singke table inheritence 
#
# These classes can probalby be removed altogether 
#    bizzspot, brownbook, byzlysts, citydata, citysearch*, craigslist (no data table) 
#    crunchbase*, cylex, 

insert into client_data(business_id, email, secrets, status, force_update, listing_url, created_at, updated_at, profile_category_id, do_not_sync, type) select business_id, email, secrets, status, force_update, listing_url, created_at, updated_at, angies_list_category_id, do_not_sync, "AngiesList" from angies_lists;
insert into client_data(business_id, force_update, secrets, username, created_at, updated_at, do_not_sync, type) select business_id, force_update, secrets, username, created_at, updated_at, do_not_sync, "Aol" from aols;
insert into client_data(business_id, local_url, email, secrets, status, force_update, created_at, updated_at, profile_category_id, do_not_sync, type) select business_id, local_url, email, secrets, status, force_update, created_at, updated_at, bing_category_id, do_not_sync, "Bing" from bings; 
insert into client_data(business_id, created_at, updated_at, secrets, do_not_sync, force_update, email, username, type ) select business_id, created_at, updated_at, secrets, do_not_sync, force_update, email, username, "Bizzspot" from bizzspots;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, email, type) select business_id, created_at, updated_at, secrets, force_update, email, "Brownbook" from brownbooks; 
insert into client_data(business_id, created_at, updated_at, secrets, force_update, email, type) select business_id, created_at, updated_at, secrets, force_update, email, "Businesscom" from businesscoms; 
insert into client_data(business_id, created_at, updated_at, secrets, force_update, email, profile_category_id, type) select business_id, created_at, updated_at, secrets, force_update, email, businessdb_category_id, "Businessdb" from businessdbs; 
insert into client_data(business_id, created_at, updated_at, secrets, force_update, email, do_not_sync, profile_category_id, type) select business_id, created_at, updated_at, secrets, force_update, email, do_not_sync, citisquare_category_id, "Citisquare" from citisquares;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, email, do_not_sync, profile_category_id, type) select business_id, created_at, updated_at, secrets, force_update, email, do_not_sync, citydata_category_id, "Citydata" from citydata;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, username, do_not_sync, profile_category_id, type) select business_id, created_at, updated_at, secrets, force_update, username, do_not_sync, cornerstonesworld_category_id, "Cornerstonesworld" from cornerstonesworlds;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, email, facebook_signin, listing_url, type) select business_id, created_at, updated_at, secrets, force_update, email, facebook_signin, listing_url, "Citysearch" from citysearches;
insert into client_data(business_id, created_at, updated_at, secrets, force_update, email, do_not_sync, profile_category_id, type) select business_id, created_at, updated_at, secrets, force_update, email, do_not_sync, digabusiness_category_id, "Digabusiness" from digabusinesses; 
insert into client_data(business_id, created_at, updated_at, secrets, force_update, email, do_not_sync, type) select business_id, created_at, updated_at, secrets, force_update, email, do_not_sync, "Discoverourtown" from discoverourtowns; 

