var Answer = function(){
    this.id;
    this.good = "0";
    this.wording = '';
};

var answer = riot.observable();
answer.apiBaseUrl = global_baseUrl+'/api/';