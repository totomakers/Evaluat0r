var session = riot.observable();
session.apiBaseUrl = '/api/sessions';

//----------------
//API ------------
//----------------

session.getAll = function(page)
{
    $.ajax({ url: session.apiBaseUrl+'?page='+page, success: session.onGetAll});
}

session.refreshAll = function(page)
{
    $.ajax({ url: session.apiBaseUrl+'?page='+page, success: session.onRefreshAll});
}

session.add = function(params)
{
    $.ajax({type: "POST", url: session.apiBaseUrl+'/add', data: params, success: session.onAdd});
}

session.delete = function(id)
{
     $.ajax({type: "DELETE", url: session.apiBaseUrl+'/'+id , success: session.onDelete});
}

session.get = function(id)
{
    $.ajax({ url: session.apiBaseUrl+'/'+id, success: session.onGet});
}

session.update = function(id, params)
{
    $.ajax({type: "PUT", url: session.apiBaseUrl+'/'+id , data: params, success: session.onUpdate});
}

session.getCandidates = function(id)
{
    $.ajax({ url: session.apiBaseUrl+'/'+id+'/candidates', success: session.onCandidates});
}

session.addCandidate = function(id, params)
{
    $.ajax({type: "POST", url: session.apiBaseUrl+'/'+id+'/candidates/add', data: params, success: session.onAddCandidate});
}

session.removeCandidate = function(id, candidateId)
{
    $.ajax({type: "DELETE", url: session.apiBaseUrl+'/'+id+'/candidates/'+candidateId, success: session.onRemoveCandidate});
}

session.getQuestions = function(id)
{
    $.ajax({ url: session.apiBaseUrl+'/'+id+'/questions', success: session.onQuestions});
}

session.putQuestions = function(id, template_id)
{
    $.ajax({type: "PUT", url: session.apiBaseUrl+'/'+id+'/questions/from/'+template_id, success: session.onPutQuestions});
}

//------------------
//EVENTS -----------s
//------------------

session.onGet = function(json)
{
    session.trigger('session_get', json);
}

session.onGetAll = function(json)
{
    session.trigger('session_getAll', json);
}

session.onAdd = function(json)
{
    session.trigger('session_add', json);
}

session.onUpdate = function(json)
{
    session.trigger('session_update', json);
}

session.onRefreshAll = function(json)
{
    session.trigger('session_refreshAll', json);
}

session.onDelete = function(json)
{
    session.trigger('session_delete', json);
}

session.onCandidates = function(json)
{
    session.trigger('session_candidates', json);
}

session.onAddCandidate = function(json)
{
    session.trigger('session_add_candidate', json);
}

session.onRemoveCandidate = function(json)
{
    session.trigger('session_remove_candidate', json);
}

session.onQuestions = function(json)
{
    session.trigger('session_questions', json);
}

session.onPutQuestions = function(json)
{
    session.trigger('session_put_questions', json);
}