var theme = riot.observable();
theme.apiBaseUrl = '/api/themes';

//----------------
//API ------------
//----------------

theme.getAll = function(page)
{
    $.ajax({ url: theme.apiBaseUrl+'?page='+page, success: theme.onGetAll});
}

theme.refreshAll = function(page)
{
    $.ajax({ url: theme.apiBaseUrl+'?page='+page, success: theme.onRefreshAll});
}

theme.add = function(params)
{
    $.ajax({type: "POST", url: theme.apiBaseUrl+'/add', data: params, success: theme.onAdd});
}

theme.delete = function(id)
{
    $.ajax({type: "DELETE", url: theme.apiBaseUrl+'/'+id, success: theme.onDelete});
}

theme.get = function(id)
{
    $.ajax({ url: theme.apiBaseUrl+'/'+id, success: theme.onGet});
}

theme.getQuestions = function(id)
{
    $.ajax({ url: theme.apiBaseUrl+'/'+id+'/questions', success: theme.onGetQuestions});
}

//-----------------
//EVENTS ----------
//-----------------

theme.onGetAll = function(json)
{
    theme.trigger('theme_getAll', json);
}

theme.onGet = function(json)
{
    theme.trigger('theme_get', json);
}

theme.onRefreshAll = function(json)
{
    theme.trigger('theme_refreshAll', json);
}

theme.onAdd = function(json)
{
    theme.trigger('theme_add', json);
}

theme.onDelete = function(json)
{
    theme.trigger('theme_delete', json);
}

theme.onGetQuestions = function(json)
{
    theme.trigger('theme_getQuestions', json);
}

theme.sortByName =  function(a, b) 
{
    var aName = a.name.toLowerCase();
    var bName = b.name.toLowerCase(); 
    return ((aName < bName) ? -1 : ((aName > bName) ? 1 : 0));
}