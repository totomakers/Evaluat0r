var themes = riot.observable();

themes.apiBaseUrl = '/api/';

//----------------
//API ------------
//----------------
themes.getAll = function()
{
    $.ajax({ url: api.apiBaseUrl+'themes', success: themes.onGetAll});
}

themes.add = function()
{
    themes.onAdd({'error':false});
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
