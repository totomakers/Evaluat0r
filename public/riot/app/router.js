//--------------
//ROUTER -------
//--------------

function router(collections, id, action)
{
    var selector = document.getElementById('app_content');
    var pageTitle = '';


    switch(collections)
    {
        case 'themes':
            pageTitle += 'Thèmes';
        
            if(!id) riot.mount(selector, 'themes');
            else
            {
                switch(action)
                {
                    case 'edit': break;
                    case 'delete': break;
                    case 'add': break;
                }
            }
            
            break;
            
        case 'modeles':
            pageTitle += 'Modèles';
        
            if(!id) riot.mount(selector, 'modeles');
            break;
        
        default: 
            pageTitle += 'Accueil';
            riot.mount(selector, 'home', api);
        break;
    }
    
    document.title = 'Evaluat0r - ' + pageTitle;
};

riot.route(router);
riot.route.exec(router);
