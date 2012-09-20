var fs = require('fs');
var all = {};
res = fs.readdirSync('./cats');
for(var i=0; i < res.length; i++) {
  // if (res[i].substr(res[i].length - 3, 3) == '.txt') {
    body = fs.readFileSync("./cats/"+res[i], 'utf8');
    body = body.replace(/^"<pre>\s*/i, '');
    body = body.replace(/\s*<\/pre>"$/i, '');
    body = 'x = ' + body + ';';
    data = eval(body);
    cats = data['result']['subcategories'];
    for(var j=0; j < cats.length; j++) {
      row = [];
      var arr = ['rcatid', 'catname', 'subcatid', 'subcatname', 'subprofcontact', 'synonyms'];
      for (p in arr) {
        row.push( cats[j][arr[p]] );
      }
      console.log( row.join("\t") )
      // console.log( JSON.stringify( cats[j].keys ) );
    }
  // }
}
