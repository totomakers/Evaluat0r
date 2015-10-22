//--------------
//ROUTER -------
//--------------

function router(collections, action, id)
{
    var selector = document.getElementById('app_content');
    var pageTitle = '';


    switch(collections)
    {
        case 'themes':
            pageTitle += 'Thèmes';
            
            switch(action)
            {
                case 'edit':
                    if(!id) riot.route('themes/all/1'); 
                    else riot.mount(selector, 'questions', {'api': api}); //'questions' : questions
                    break;
                case 'delete': break;
                case 'add': break;
                
                default:
                case 'all':
                     if(!id) id = 1;
                     riot.mount(selector, 'themes', {'api': api, 'themes' : themes, 'page' : { id : id} });
                    break;
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
