var auth = riot.observable();
auth.apiBaseUrl = '/api/accounts';

//----------------
//API ------------
//----------------
auth.login = function(params) 
{
    $.ajax({type: "POST", url: auth.apiBaseUrl+'/login', data: params, success: auth.triggerLogin});
}

auth.profile = function()
{
    $.ajax({ url: auth.apiBaseUrl+'/profil', success: auth.triggerProfile});
}

auth.logout = function()
{
    $.ajax({ url: auth.apiBaseUrl+'/logout', success: auth.onLogout});
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

auth.onLogout = function(json)
{
    document.location.href = '/';
}