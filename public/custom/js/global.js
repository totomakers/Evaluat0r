//------------
//LOADER -----
//------------

var loader = {};

loader.show = function(selector)
{
    selector = typeof selector !== 'undefined' ? selector : '#app_loader';
    $(selector).show();
}

loader.hide = function(selector)
{
    selector = typeof selector !== 'undefined' ? selector : '#app_loader';
    $(selector).hide();
}

//--------------
//ALERT --------
//--------------

var alert = {};
alert.show = function(selector, type, message)
{
    box = $(selector);
    messageBuffer = "";
    
    if(Array.isArray(message))
    {
        for(var i = 0; i < message.length; i++)
            messageBuffer += message[i] + "</br>";
    }
    else
        messageBuffer = message;
        
    
    box[0].innerHTML = '<div class="alert alert-'+type+' alert-dismissible animated fadeIn"> \
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button> \
                    '+messageBuffer+'</div>';
                    
    box.show();
} 

//-------------
//PAGINATION --
//-------------

var pagination = {}
pagination.refreshPagination = function(selectorBox, selectorPagination, pagination, handlerPageClick)
{
    $(selectorPagination).remove();
    
    if(pagination.last_page == '0') 
        return;
   
    $(selectorBox).html("<span id='"+selectorPagination.replace('#', '')+"' class='pagination-sm'/></span>");
    $(selectorPagination).twbsPagination({
        totalPages: pagination.last_page,
        visiblePages: 8,
        startPage: pagination.current_page,
        onPageClick: handlerPageClick,
        first: 'Première page',
        prev:  'Précèdent',
        next: 'Suivant',
        last: 'Dernière page',
    });
}

//-------------
//UTILS -------
//-------------

var formatTime =function(value) {
    var res = value.replace(":", "h").substring(0, 5);

    return res;
}
var refreshTooltip = function()
{
    var tooltips = $('[data-toggle="tooltip"]');
    tooltips.tooltip();  
}

var byId = function(e)
{
    return e.id;
}

var dateFormatFr = function(date)
{
    return moment(date, 'YYYY-MM-DD').format('DD/MM/YYYY');
}

var dateTimeFormatFr = function(datetime)
{
    return moment(datetime, 'YYYY-MM-DD HH:mm:ss').format('DD/MM/YYYY HH:mm:ss');
}