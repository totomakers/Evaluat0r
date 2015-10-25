<themes hidden>
    <div class="animated fadeIn">
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
                    <table id="themes_data" class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Nom</th>
                                <th>Déscription</th>
                                <th class="text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input type="text" class="form-control" id="themes_add_name" placeholder="Nom"></input></td>
                                <td><input type="text" class="form-control" id="themes_add_description" placeholder="Description"></input></td>
                                <td class="text-right"><button id="themes_add_button" class="btn btn-success btn-lg" onclick={themes_add}><i id="themes_add_button_ico" class="fa fa-plus fa-lg"></i></button></td>
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
                <div class="col-lg-12 text-center" id="themes_pagination_box">
                </div>
            </div>
        </div>
    </div>
    
    <script>
        var self = this;
        self.themes = [];
        
        loader.show();

        this.on('mount',function() {
            opts.themes.getAll(opts.page.id);            
        });

        //--------------------
        //UTILS -
        //--------------------

        self.addForm = function(enable, clear)
        {
            //button
            var name = $('#themes_add_name');
            var description = $('#themes_add_description');
            var button = $('#themes_add_button');
            var button_icon =  $('#themes_add_button_ico');

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

        themes_add(e) {
            var name = $('#themes_add_name');
            var description = $('#themes_add_description');
        
            self.addForm(false, false);
            var value = { "name" : name.val(), "description" : description.val() }
            opts.themes.add(value);
        }
        
        theme_edit(e) {
            riot.route('themes/edit/'+(e.item.id));
        }
        
        theme_delete(e) {
            opts.themes.delete(e.item.id);
        }
        
        var pageClick = function(event, page)
        {
            var themesData= $('#themes_data');
            themesData.addClass("animated slideOutRight");
            opts.page.id = page;

            opts.themes.getAll(page);
        }
            
        //---------------
        //EVENT ---------
        //---------------
        
        opts.themes.on('themes_getAll', function(json) 
        {
            loader.hide();
            
            //---------
            self.themes = json.data.data;
            if(Array.isArray(self.themes) == false) self.themes = [ self.themes ];
            self.themes.sort(opts.themes.sortByName);
            self.themes.count = json.data.total;
            self.update();
            
            var themesData= $('#themes_data');
            themesData.one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function()
            {
                themesData.removeClass("animated slideOutRight");
                themesData.addClass("animated slideInLeft");
            });
           
            refreshTooltip();
            pagination.refreshPagination('#themes_pagination_box', '#themes_pagination', json.data, pageClick);
        });  
        
        opts.themes.on('themes_refreshAll', function(json) 
        {
            self.themes = json.data.data;
            if(Array.isArray(self.themes) == false) self.themes = [ self.themes ];
            self.themes.count = json.data.total;
            self.themes.sort(opts.themes.sortByName);
            self.update();
           
            refreshTooltip();
            pagination.refreshPagination('#themes_pagination_box', '#themes_pagination', json.data, pageClick);
        });

        opts.themes.on('themes_add', function(json) 
        {
            if(json.error)
                alert.show('#alert-box', 'danger', json.message);
            else
                alert.show('#alert-box', 'success', json.message);
                
            self.addForm(true, (json.error == false));
            if(json.error == false) opts.themes.refreshAll(opts.page.id);
        });

        opts.themes.on('themes_delete', function(json) 
        {
            if(json.error)
                alert.show('#alert-box', 'danger', json.message);
            else
                alert.show('#alert-box', 'success', json.message);
            
            opts.themes.refreshAll(opts.page.id);  
        });
        
    </script>
</themes>