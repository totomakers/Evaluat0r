var evaluation = riot.observable();
evaluation.apiBaseUrl = global_baseUrl+'/api/evaluations';

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

evaluation.getQuestions = function(id)
{
    $.ajax({ url : evaluation.apiBaseUrl+'/'+id+'/questions', success: evaluation.onGetQuestions});
}

evaluation.getAnswers = function(id)
{
    $.ajax({url : evaluation.apiBaseUrl+'/'+id+'/answers', success: evaluation.onGetAnswers});
}

evaluation.postAnswers = function(id, answers)
{
    $.ajax({type: "POST", url : evaluation.apiBaseUrl+'/'+id+'/answers', data: { 'answers': answers }, success: evaluation.onPostAnswers});
}

evaluation.getTimer = function(id)
{
    $.ajax({url : evaluation.apiBaseUrl+'/'+id+'/timer', success: evaluation.onGetTimer}); 
}

//--------------------------
//--------------------------

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

evaluation.onGetQuestions = function(json)
{
    evaluation.trigger('evaluation_questions', json);
}

evaluation.onGetAnswers = function(json)
{
    evaluation.trigger('evaluation_get_answers', json);
}

evaluation.onPostAnswers = function(json)
{
    evaluation.trigger('evaluation_post_answers', json);
}

evaluation.onGetTimer = function(json)
{
    evaluation.trigger('evaluation_get_timer', json);
}
