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

//------------------
//EVENTS -----------
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