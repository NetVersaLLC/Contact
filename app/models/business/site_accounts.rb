module Business::SiteAccounts
  extend ActiveSupport::Concern
  included do 
    def self.site_accounts
      [
        ['Aol', 'aols',
          [
            ['text', 'username'],
            ['text', 'password']
          ]
        ],
        ['AngiesList', 'angies_lists',
          [
            ['text', 'email'],
            ['text', 'password']
          ]
        ],
        ['Businesscom', 'businesscoms',
          [
            ['text', 'email'],
            ['text', 'password']
          ]
        ],
        ['Citisquare', 'citisquares',
          [
            ['text', 'email'],
            ['text', 'password']
          ]
        ],
        ['Getfav', 'getfavs',
          [
            ['text', 'email'],
            ['text', 'password']
          ]
        ],
        ['Merchantcircle', 'merchantcircles',
          [
            ['text', 'email'],
            ['text', 'password']
          ]
        ],
        ['Manta', 'mantas',
          [
            ['text', 'email'],
            ['text', 'password']
          ]
        ],
        ['Mojopage', 'mojopages',
          [
            ['text', 'email'],
            ['text', 'password']
          ]
        ],
        ['Twitter', 'twitters',
          [
            ['text', 'username'],
            ['text', 'password']
          ]
        ],
        ['Facebook', 'facebooks',
          [
            ['text', 'email'],
            ['text', 'password']
          ]
        ],
        ['YellowBot', 'yellow_bots',
          [
            ['text', 'email'],
            ['text', 'username'],
            ['text', 'password']
          ]
        ],
        ['Bing', 'bings',
          [
            ['text', 'email'],
            ['text', 'password'],
            ['text', 'secret_answer'],
            ['select', 'bing_category']
          ]
        ],
        ['Google', 'googles',
          [
            ['text', 'email'],
            ['text', 'password']
          ]
        ],
        ['Yahoo', 'yahoos',
          [
            ['text', 'email'],
            ['text', 'password'],
            ['text', 'secret1'],
            ['text', 'secret2'],
            ['select', 'yahoo_category']
          ]
        ],
        ['Yelp', 'yelps',
          [
            ['text', 'email'],
            ['text', 'password']
          ]
        ],
        ['Foursquare', 'foursquares',
          [
            ['text', 'email'],
            ['text', 'password']
          ]
        ],
        ['Localdatabase', 'localdatabases',
          [
            ['text', 'username'],
            ['text', 'password']
          ]
        ],
        ['Crunchbase', 'crunchbases',
          [
            ['text', 'username'],
            ['text', 'password']
          ]
        ],
        ['Tupalo', 'tupalos',
          [
            ['text', 'username'],
            ['text', 'password']
          ]
        ],
        ['Mapquest', 'map_quests',
          [
            ['text', 'email'],
            ['text', 'password']
          ]
        ]
      ]
    end
  end
end
