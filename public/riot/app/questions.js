var questions = riot.observable();
questions.apiBaseUrl = '/api/';

//----------------
//API ------------
//----------------
questions.add = function(params)
{
    $.ajax({type: "POST", url: api.apiBaseUrl+'questions/add', data: params, success: questions.onAdd});
}

//-----------------
//EVENTS ----------
//-----------------
questions.onAdd = function(json)
{
    questions.trigger('questions_onAdd', json);
}