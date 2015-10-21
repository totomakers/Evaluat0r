<themes hidden>
    <div class="animated fadeIn">
        <div class="row">
            <div class="col-lg-12">
                <h1>Themes <small> - {themes.count} disponible(s)</small></h1>
                <hr>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div id="alert" class="alert alert-danger animated fadeIn" hidden></div>
            </div>
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
                                    <a href=""><i data-toggle="tooltip" data-placement="top" title="Editer" class="fa fa-pencil fa-lg"/></a>
                                    &nbsp;&nbsp;
                                    <a href="" onclick={theme_delete}><i data-toggle="tooltip" data-placement="top" title="Supprimer" class="fa fa-red fa-trash fa-lg"/></a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class=col-lg-12 text-center" id="themes_pagination_box">
                    <ul id="themes_pagination" class="pagination-sm"/></ul>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        var self = this;
        loader.show();

        //When tag is mounted
        this.on('mount',function() {
            opts.themes.getAll(opts.page.id); 
        });

        //--------------------
        //UTILS -
        //--------------------
        
        //navigation pagination
        var pageClick = function(event, page)
        {
            var themesData= $('#themes_data');
            themesData.addClass("animated slideOutRight");
            
            opts.themes.getAll(page);
        }
        
        var refreshPagination = function(json)
        {
             //apply pagination
            $('#themes_pagination').remove();
            $('#themes_pagination_box').html("<ul id='themes_pagination' class='pagination-sm'/></ul>");
            $('#themes_pagination').twbsPagination({
                totalPages: json.data.last_page,
                visiblePages: 8,
                startPage: json.data.current_page,
                onPageClick: pageClick,
            });
        }
        
        var refreshTooltip = function()
        {
           var tooltips = $('[data-toggle="tooltip"]');
           tooltips.tooltip();  
        }
        
         //Enable/Disable add form
        var addForm = function(enable, clear)
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
        
        //Click on button add
        themes_add(e) {
            var name = $('#themes_add_name');
            var description = $('#themes_add_description');
        
            addForm(false, false);
            var value = { "name" : name.val(), "description" : description.val() }
            opts.themes.add(value);
        }
        
        theme_delete(e) {
            opts.themes.delete(e.item.id);
        }
        
        
        //---------------
        //EVENT ---------
        //---------------
        
        //First load
        opts.themes.on('themes_getAll', function(json) 
        {
            loader.hide();
            
            //---------
            self.themes = json.data.data;
            self.themes.count = json.data.total;
            self.themes.sort(opts.themes.sortByName);
            self.update();
            
            //page nav animation
            var themesData= $('#themes_data');
            themesData.one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function()
            {
                themesData.removeClass("animated slideOutRight");
                themesData.addClass("animated slideInLeft");
            });
           
            refreshPagination(json);
            refreshTooltip();
        });  
        
        //Refresh
        opts.themes.on('themes_refreshAll', function(json) 
        {
            console.log('themes refresh');
            self.themes = json.data.data;
            self.themes.count = json.data.total;
            self.themes.sort(opts.themes.sortByName);
            self.update();

            refreshTooltip();
            refreshPagination(json);
        });
        
        
        //Ajout de theme reussi
        opts.themes.on('themes_add_success', function(json) {
            var alert = $('#alert');
            alert.hide();
            alert.empty();
            alert.removeClass("alert-danger");
            alert.addClass("alert-success");
            alert.append(json.message);
            alert.show();
   
            addForm(true, true);
            opts.themes.refreshAll(opts.page.id);
            
            //apply tooltip
            var tooltips = $('[data-toggle="tooltip"]');
            tooltips.tooltip();  
        });
        
        //Ajout de theme échoué
        opts.themes.on('themes_add_fail', function(json) {
            var alert = $('#alert');
            alert.hide();
            alert.empty();
            alert.removeClass("alert-success");
            alert.addClass("alert-danger"); 
            json.message.forEach(function(value){
                alert.append(value+"</br>");
            });
            alert.show();
            
            addForm(true, false);
        });
        
        //Suppression theme
        opts.themes.on('theme_delete', function(json) {
            var alert = $('#alert');
            alert.hide();
            alert.empty();
            
            if(json.error)
            {
                alert.removeClass("alert-success");
                alert.addClass("alert-danger"); 
            }
            else
            {
                alert.removeClass("alert-danger");
                alert.addClass("alert-success");
            }
            
            alert.append(json.message);
            alert.show();
            
            opts.themes.refreshAll(opts.page.id);
            
            //apply tooltip
            var tooltips = $('[data-toggle="tooltip"]');
            tooltips.tooltip();  
        });
        
       
    </script>
</themes>