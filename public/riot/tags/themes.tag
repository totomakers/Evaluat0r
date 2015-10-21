<themes hidden>
    <div class="animated fadeIn">
        <div class="row">
            <div class="col-lg-12">
                <h1>Themes <small> - {themes.length} disponible(s)</small></h1>
                <hr>
            </div>
        <div>
       <div class="row">
       </div>
       <div class="row">
            <div class="col-lg-12">
                <div class="table">
                    <table class="table table-striped table-hover">
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
                                    <a href=""><i data-toggle="tooltip" data-placement="top" title="Supprimer" class="fa fa-red fa-trash fa-lg"/></a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        var self = this;
        loader.show();

        //on mount
        this.on('mount',function() {
            opts.themes.getAll(); 
        });

        //themes load
        opts.themes.on('themes_getAll', function(json) 
        {
            loader.hide();
            self.themes = json.data;
            self.update();

            //apply tooltip
            var tooltips = $('[data-toggle="tooltip"]');
            tooltips.tooltip();  
        });  
        
        //themes add
        themes_add(e) {
            var name = $('#themes_add_name');
            var description = $('#themes_add_description');
        
            addForm(false);
            var value = { "name" : name.val(), "description" : description.val() }
            opts.themes.add(value);
        }
        
        var addForm = function(enable)
        {
            //button
            var name = $('#themes_add_name');
            var description = $('#themes_add_description');
            var button = $('#themes_add_button');
            var button_icon =  $('#themes_add_button_ico');

            if(enable == true)
            {
                console.log('activé');
                name.removeAttr('disabled');
                description.removeAttr('disabled');
                button.removeAttr('disabled');

                description.val("");
                name.val("");
              
                button_icon.addClass('fa-plus');
                button_icon.removeClass('fa-spinner');
                button_icon.removeClass('fa-spin');
            }
            else
            {
                console.log('déactiver');
                name.attr('disabled', 'disabled');
                description.attr('disabled', 'disabled');
                button.attr('disabled', 'disabled');
                
                button_icon.removeClass('fa-plus');
                button_icon.addClass('fa-spinner fa-spin');
            }
        }
        
        //when theme add success
        opts.themes.on('themes_add_success', function(json) {
            self.update();
            addForm(true);
        });
        
        //when theme add fail
        opts.themes.on('themes_add_fail', function(json) {
            addForm(true);
        });
       
    </script>
</themes>