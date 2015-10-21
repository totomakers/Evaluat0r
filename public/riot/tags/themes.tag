<themes hidden>
    <div class="animated fadeIn">
        <div>
            <h1>Themes <small> - {themes.length} disponible(s)</small></h1>
            <hr>
        </div>
        <div class="row">
            <div class="col-12">
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Nom</th>
                                <th>Déscription</th>
                                <th class="text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr each={themes}>
                                <td>{name}</td>
                                <td>{description}</td>
                                <td class="text-right">
                                    <a href=""><i data-toggle="tooltip" data-placement="top" title="Editer" class="fa fa-pencil fa-lg"/></a>
                                    &nbsp;&nbsp;
                                    <a href=""><i data-toggle="tooltip" data-placement="top" title="Supprimer" class="fa fa-trash fa-lg"/></a>
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

        //call api
        this.on('mount',function() {
            opts.themes(); 
        });

        //theme ok
        opts.on('themes_loaded', function(json) 
        {
            loader.hide();
            self.themes = json.data;
            self.update();

            //apply tooltip
            var tooltips = $('[data-toggle="tooltip"]');
            tooltips.tooltip();  
        });  
    </script>
</themes>