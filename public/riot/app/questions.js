var questions = riot.observable();
questions.apiBaseUrl = '/api/';

//----------------
//API ------------
//----------------
questions.add = function(params)
{
    $.ajax({type: "POST", url: api.apiBaseUrl+'questions/add', data: params, success: questions.onAdd});
}

questions.refresh = function()
{
    questions.trigger('questions_refresh');
}

questions.delete = function(id)
{
     $.ajax({type: "DELETE", url: api.apiBaseUrl+'questions/'+id, success: questions.onDelete});
}

//-----------------
//EVENTS ----------
//-----------------
questions.onAdd = function(json)
{
    questions.trigger('questions_add', json);
}

questions.onDelete = function(json)
{
    questions.trigger('questions_delete', json);
}