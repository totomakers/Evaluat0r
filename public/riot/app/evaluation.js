var evaluation = riot.observable();
evaluation.apiBaseUrl = '/api/evaluations';

//----------------
//API ------------
//----------------

evaluation.get = function(status)
{
    var successCallback;
    
    switch(status)
    {
        case 'available': successCallback = evaluation.onGetAvailable; break;
        case 'in_progress': successCallback = evaluation.onGetInProgress; break;
        case 'ended': successCallback = evaluation.onGetEnded; break;
        default:
            console.log('invalid status : ' + status);
            break;
    }

    $.ajax({ url: evaluation.apiBaseUrl+'?status='+status, success: successCallback});
}

evaluation.start = function(session_id)
{
    $.ajax({ url: evaluation.apiBaseUrl+'/start/'+session_id, success: evaluation.onStart});
}

//*WARNING* return session *WARNING*
evaluation.onGetAvailable = function(json)
{
    evaluation.trigger('evaluation_available', json);
}

evaluation.onGetInProgress = function(json)
{
    evaluation.trigger('evaluation_in_progress', json);
}

evaluation.onGetEnded = function(json)
{
    evaluation.trigger('evaluation_ended', json);
}

evaluation.onStart = function(json)
{
    evaluation.trigger('evaluation_start', json);
}