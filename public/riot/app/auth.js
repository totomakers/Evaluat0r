var auth = riot.observable();

auth.apiBaseUrl = '/api/';

//----------------
//API ------------
//----------------
auth.login = function(params) 
{
    $.ajax({type: "POST", url: auth.apiBaseUrl+'accounts/login', data: params, success: auth.triggerLogin});
}

auth.profile = function()
{
    $.ajax({ url: auth.apiBaseUrl+'accounts/profil', success: auth.triggerProfile});
}

//-----------------
//EVENTS ----------
//-----------------
auth.triggerLogin = function(json)
{
    auth.trigger('login', json);
}

auth.triggerProfile = function(json)
{
    auth.trigger('profile', json);
}

