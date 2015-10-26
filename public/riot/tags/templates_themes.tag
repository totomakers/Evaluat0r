<templates_themes>
    <div id="subloader" hidden>
        <i class="fa fa-spinner fa-spin fa-3x"/>
    </div>
    <div id="templates-themes-content" class="animated fadeIn" hidden>
        <div class="row">
            <div class="col-lg-12">
                <h2><small>{themes.length} thème(s)</small></h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="table">
                    <table class="table table-striped table-hover">
                        <thead>
                            <th>Thèmes</th>
                            <th>Nombre de questions ?</th>
                            <th>Actions</th>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input type="text" class="form-control" id="modele_theme_name" placeholder="Votre thème"></input></td>
                                <td><input type="text" class="form-control" id="modele_theme_questions_count" placeholder="Nombre de question"></input></td>
                                <td><button id="model_theme_add_button" class="btn btn-success btn-lg" onclick={models_add}><i id="model_theme_button_ico" class="fa fa-plus fa-lg"></i></button></td>
                            </tr>
                            <tr each={themes}>
                                <td><a href="#themes/edit/{ pivot.theme_id }">{name}</a></td>
                                <td>{ pivot.question_count } questions</td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        var self = this;
        self.themes = [];
        
        this.on('mount', function(){
        });
        
        opts.template.on('template_themes', function(json)
        {
            self.themes = json.data;
            self.update();
        
            loader.hide('#subloader');
            $('#templates-themes-content').show();
        });
        
        opts.template.on('templates_themes_hide', function()
        {
             $('#templates-themes-content').hide();
        });
        
        opts.template.on('templates_themes_loading', function()
        {
            loader.show('#subloader');
            $('#templates-themes-content').hide();
        });
        
    </script>
</templates_themes>