var api = riot.observable();

api.apiBaseUrl = '/api/';

//----------------
//API ------------
//----------------
api.login = function(params) 
{
    $.ajax({type: "POST", url: api.apiBaseUrl+'accounts/login', data: params, success: api.triggerLogin});
}

api.profile = function()
{
    $.ajax({ url: api.apiBaseUrl+'accounts/profil', success: api.triggerProfile});
}

api.logout = function()
{
    $.ajax({ url: api.apiBaseUrl+'accounts/logout', success: api.onLogout});
}

api.themes = function()
{
    $.ajax({ url: api.apiBaseUrl+'themes', success: api.onThemes});
}


//-----------------
//EVENTS ----------
//-----------------
api.triggerLogin = function(json)
{
    api.trigger('login', json);
}

api.triggerProfile = function(json)
{
    api.trigger('profile', json);
}

api.onLogout = function(json)
{
    document.location.href = '/';
}

api.onThemes = function(json)
{
    api.trigger('themes_loaded', json);
}

