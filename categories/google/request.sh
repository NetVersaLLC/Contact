##
## Paste in the headers from a open session logged in to
## http://www.google.com/local/add/details
##
## Then run ./get_all.sh which downloads queries into ./cats
##
## Next run $ node parse.js > final_list.js
##
## This will generate the final hash of ids to names json. Finally run
## rake categories:google
##
## This will import Google categories.

export query=$1;
curl -XGET -v -H "GET /maps/ot?hl=en&gl=US&ottype=1&q=$query&num=100&callback=_callbacks_._0h5kzwerv HTTP/1.1\nHost: maps.google.com\nConnection: keep-alive\nUser-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_4) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.57 Safari/537.1\nAccept: */*\nX-Chrome-Variations: CKm1yQEIkbbJAQigtskBCKO2yQEIqLbJAQjCg8oB\nReferer: http://www.google.com/local/add/details?hl=en-US&gl=US&storeid=4605932557096024113&mode=existing&lookup=NO_RESULTS&flowtype=os\nAccept-Encoding: gzip,deflate,sdch\nAccept-Language: en-US,en;q=0.8\nAccept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.3\nCookie: PREF=ID=a6b7305a0b1fae26:U=6761d0515e558a20:FF=0:LD=en:TM=1344311057:LM=1344344081:S=Qg5rtgjS5nc0HIjr; NID=62=iPG1AFedExZoPXSkJ4wRWsehU6yUKXbXD6QQxJtZmnB1xgnY-VLETG_t76Yy1-jn1A6fmlB27LkWpxKUdZhwBWHBdWRDkdgW0N_uMRADMjEutoz-qzscFISGrZk4U3JDiakteGB6MowWDrqYOGcRo2iZgFfmF3tbGFogMJrqwk29AV9ltKjXtV6aE-wW0hP2; HSID=AMP2aW2Qb9XiYbUMi; APISID=7b7d0IJTjSQtgUj4/A9gh61lciRonecMTP; SID=DQAAAL0AAABdZLi5um-5VKxevpcsNdlfYavm7nlQTsbPYHN0dWxE00PfJe1UOYaKQnk3ytIcmDanHMli-HabKg6W9IOb8Umjdty6z8jrATY_Tb5DOsIEtUD4Z593VxP5Asn99CB3WzIWXur89I1JAtFrE8334ox44WhPPhQTW7Nt2BZ8OoZkT-EY--C4awauNX-2zVszEDo8XHBAYbG_TL1Pl_-0-jWFhWNdeTTxv7_1OuLyGn-ThTxuAm4tq0bVtJw7Wu7fUFc; S=localbusinesscenter=QvUaUbBRm-pvQDMs3McXOg" "http://maps.google.com/maps/ot?hl=en&gl=US&ottype=1&q=$query&num=100&callback=_callbacks_._0h5kzwerv"
