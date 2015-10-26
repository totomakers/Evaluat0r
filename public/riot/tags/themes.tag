<themes>
    <div class="animated fadeIn" id="themes-body" hidden>
        <div class="row">
            <div class="col-lg-12">
                <h1>Thèmes <small> - {themes.count} disponible(s)</small></h1>
                <hr>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12" id="alert-box"></div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="table">
                    <table id="themes-data" class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Nom</th>
                                <th>Déscription</th>
                                <th class="text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input type="text" class="form-control" id="themes-add-name" placeholder="Nom"></input></td>
                                <td><input type="text" class="form-control" id="themes-add-description" placeholder="Description"></input></td>
                                <td class="text-right"><button id="themes-add-button" class="btn btn-success btn-lg" onclick={theme_add}><i id="themes-add-button-ico" class="fa fa-plus fa-lg"></i></button></td>
                            </tr>
                            <tr each={themes}>
                                <td>{name}</td>
                                <td>{description}</td>
                                <td class="text-right">
                                   { questions.length } questions &nbsp; &nbsp;
                                    <a href="" onclick={theme_edit}><i data-toggle="tooltip" data-placement="top" title="Gérer la/les question(s)" class="fa fa-plus fa-lg"></i></a>
                                    &nbsp;&nbsp;
                                    <a href="" onclick={theme_delete}><i data-toggle="tooltip" data-placement="top" title="Supprimer" class="fa fa-red fa-trash fa-lg"/></a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 text-center" id="themes-pagination-box">
                </div>
            </div>
        </div>
    </div>
    
    <script>
        var self = this;
        self.themes = [];
        loader.show();

        this.on('mount',function() {
            opts.theme.getAll(opts.page.id);            
        });

        //--------------------
        //UTILS -
        //--------------------

        self.addForm = function(enable, clear)
        {
            //button
            var name = $('#themes-add-name');
            var description = $('#themes-add-description');
            var button = $('#themes-add-button');
            var button_icon =  $('#themes-add-button-ico');

            if(enable == true)
            {
                name.removeAttr('disabled');
                description.removeAttr('disabled');
                button.removeAttr('disabled');

                if(clear)
                {
                    description.val("");
                    name.val("");
                }
                
                button_icon.addClass('fa-plus');
                button_icon.removeClass('fa-spinner');
                button_icon.removeClass('fa-spin');
            }
            else
            {
                name.attr('disabled', 'disabled');
                description.attr('disabled', 'disabled');
                button.attr('disabled', 'disabled');
                
                button_icon.removeClass('fa-plus');
                button_icon.addClass('fa-spinner fa-spin');
            }
        }
        
        //---------------
        //SIGNAL --------
        //---------------

        theme_add(e) {
            var name = $('#themes-add-name');
            var description = $('#themes-add-description');
        
            self.addForm(false, false);
            var value = { "name" : name.val(), "description" : description.val() }
            opts.theme.add(value);
        }
        
        theme_edit(e) {
            riot.route('themes/edit/'+(e.item.id));
        }
        
        theme_delete(e) {
            opts.theme.delete(e.item.id);
        }
        
        var pageClick = function(event, page)
        {
            var themesData= $('#themes-data');
            themesData.addClass("animated slideOutRight");
            opts.page.id = page;
            riot.route.stop();
            riot.route('themes/all/'+page);
            riot.route.start();
            riot.route(router);

            opts.theme.getAll(page);
        }
            
        //---------------
        //EVENT ---------
        //---------------
        
        opts.theme.on('theme_getAll', function(json) 
        {
            //---------
            self.themes = json.data.data;
            if(Array.isArray(self.themes) == false) self.themes = [ self.themes ];
            self.themes.sort(opts.theme.sortByName);
            self.themes.count = json.data.total;
            self.update();
            
            var themesData= $('#themes-data');
            themesData.one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function()
            {
                themesData.removeClass("animated slideOutRight");
                themesData.addClass("animated slideInLeft");
            });
           
            refreshTooltip();
            pagination.refreshPagination('#themes-pagination-box', '#themes-pagination', json.data, pageClick);
            
            loader.hide();
            $('#themes-body').show();
        });  
        
        opts.theme.on('theme_refreshAll', function(json) 
        {
            self.themes = json.data.data;
            if(Array.isArray(self.themes) == false) self.themes = [ self.themes ];
            self.themes.count = json.data.total;
            self.themes.sort(opts.theme.sortByName);
            self.update();
           
            refreshTooltip();
            pagination.refreshPagination('#themes-pagination-box', '#themes-pagination', json.data, pageClick);
        });

        opts.theme.on('theme_add', function(json) 
        {
            if(json.error)
                alert.show('#alert-box', 'danger', json.message);
            else
                alert.show('#alert-box', 'success', json.message);
                
            self.addForm(true, (json.error == false));
            if(json.error == false) opts.theme.refreshAll(opts.page.id);
        });

        opts.theme.on('theme_delete', function(json) 
        {
            if(json.error)
                alert.show('#alert-box', 'danger', json.message);
            else
                alert.show('#alert-box', 'success', json.message);
            
            opts.theme.refreshAll(opts.page.id);  
        });
        
    </script>
</themes>