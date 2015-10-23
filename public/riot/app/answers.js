var Answer = function(){
    this.id;
    this.good = "0";
    this.wording = '';
};

var answers = riot.observable();
answers.apiBaseUrl = '/api/';