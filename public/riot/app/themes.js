var themes = riot.observable();

themes.apiBaseUrl = '/api/';

//----------------
//API ------------
//----------------
themes.getAll = function(page)
{
    $.ajax({ url: themes.apiBaseUrl+'themes?page='+page, success: themes.onGetAll});
}

themes.add = function(params)
{
    $.ajax({type: "POST", url: api.apiBaseUrl+'themes/add', data: params, success: themes.onAdd});
}

themes.delete = function(id)
{
    $.ajax({type: "DELETE", url: api.apiBaseUrl+'themes/delete/'+id, success: themes.onDelete});
}

//-----------------
//EVENTS ----------
//-----------------
themes.onGetAll = function(json)
{
    themes.trigger('themes_getAll', json);
}

themes.onAdd = function(json)
{
    if(json.error == true)
        themes.trigger('themes_add_fail', json);
    else
    {
        themes.trigger('themes_add_success', json);
    }
}

themes.onDelete = function(json)
{
    themes.trigger('theme_delete', json);
}

themes.sortByName =  function(a, b) 
{
  var aName = a.name.toLowerCase();
  var bName = b.name.toLowerCase(); 
  return ((aName < bName) ? -1 : ((aName > bName) ? 1 : 0));
}