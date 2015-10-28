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

auth.getAvailableEvaluations = function()
{
    
}

auth.getEvaluations = function(status)
{
    var successCallback;
    
    switch(status)
    {
        case 'available': successCallback = auth.onGetEvaluationsAvaialble; break;
        case 'in_progress': successCallback = auth.onGetEvaluationsInProgress; break;
        case 'ended': successCallback = auth.onGetEvaluationsEnded; break;
        default:
            console.log(status);
            break;
    }

    $.ajax({ url: auth.apiBaseUrl+'/evaluations?status='+status, success: successCallback});
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

auth.onGetEvaluationsAvaialble = function(json)
{
    console.log(json);
    auth.trigger('account_evaluations_available', json);
}

auth.onGetEvaluationsInProgress = function(json)
{
    console.log(json);
    auth.trigger('account_evaluations_in_progress', json);
}