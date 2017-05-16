var request  = require('request');
var protocol = "https://";
var host     = "test03-services.datafordeler.dk";
var endpoint = protocol+host;
var bbr      = "/BBR/BBR/1/rest";
var dar      = "/DAR/DAR/1/rest";
var mu       = "/Matrikel/Matrikel/1/REST";
var format   = "?format=json";
var username = "&username=YZYEYXVKFX";
var password = "&password=Test1234";
var metode   = "/grund";


bfenr = process.argv[2];
console.log(bfenr);

url = endpoint+bbr+metode+format+username+password+"&BFEnummer="+bfenr;
var options = {
    url: url,
    json: true,
    method: 'GET',
    headers: {
        'Host': host,
        'Cache-Control' : 'no-cache'
    }
};

console.log(url);

function callback(error, response, body) {
    if (!error && response.statusCode == 200) {
        console.log(body);
        console.log(body.length)
    } else {
        console.log(response.statusCode);
        //console.log(response.body);
    }
}
request(options,callback);
