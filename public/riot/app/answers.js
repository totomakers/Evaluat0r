var Answer = function(){
    this.id;
    this.good = false;
    this.wording = '';
};

var answers = riot.observable();
answers.apiBaseUrl = '/api/';