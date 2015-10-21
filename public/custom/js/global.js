var loader = {};

loader.show = function()
{
    $('#app_loader').show();
    $('#app_content').hide();
};

loader.hide = function()
{
    $('#app_loader').hide();
    $('#app_content').show();
};
