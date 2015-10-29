var question = riot.observable();
question.apiBaseUrl = global_baseUrl+'/api/questions';

//----------------
//API ------------
//----------------
question.add = function(params)
{
    $.ajax({type: "POST", url: question.apiBaseUrl+'/add', data: params, success: question.onAdd});
}

question.refresh = function()
{
    question.trigger('question_refresh');
}

question.delete = function(id)
{
     $.ajax({type: "DELETE", url: question.apiBaseUrl+'/'+id, success: question.onDelete});
}

//-----------------
//EVENTS ----------
//-----------------
question.onAdd = function(json)
{
    question.trigger('question_add', json);
}

question.onDelete = function(json)
{
    question.trigger('question_delete', json);
}