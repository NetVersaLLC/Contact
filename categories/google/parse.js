var fs = require('fs');
var all = {};
res = fs.readdirSync('./cats');
for(var i=0; i < res.length; i++) {
  if (res[i].substr(res[i].length - 3, 3) == '.js') {
    body = fs.readFileSync("./cats/"+res[i], 'utf8');
    body = body.replace(/^.*?\(/, '');
    body = body.replace(/\)$/, ';');
    body = body.replace(/,truncated:true/, '');
    data = eval(body);
    if (data != undefined) {
      for (ent in data) {
        all[data[ent]['id']] = data[ent]['cname']['text']
      }
    }
  }
}

console.log( JSON.stringify(all) );
