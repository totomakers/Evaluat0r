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
                            <th>Nb. questions</th>
                            <th>Actions</th>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="col-md-6"><select class="form-control" id="modele-theme-theme-name" placeholder=""></select></td>
                                <td><input type="text" class="form-control" id="modele-theme-questions-count" placeholder=""></input></td>
                                <td><button id="model-theme-add-button" class="btn btn-success btn-lg" onclick={models_add}><i id="model_theme_button_ico" class="fa fa-plus fa-lg"></i></button></td>
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
        
        self.select2ThemeTemplate = function(result) 
        {
            if (result.loading) return "Chargement...";
        
            var markup = '<div>'+result.name+'</div>'
            return markup;
        }
          
        self.select2ThemeSelect = function(selection) {
            return selection.name;
        }
        
        opts.template.on('template_themes', function(json)
        {
            self.themes = json.data;
            self.update();
        
            loader.hide('#subloader');
            $('#templates-themes-content').show();
            
            //refresh select2
            $("#modele-theme-theme-name").select2({
                  language: 'fr',
                  minimumInputLength: 2,
                  ajax: {
                    url: "api/themes/select2",
                    dataType: 'json',
                    delay: 250,
                    data: function (params) {
                      return {
                        q: params.term, // search term
                      };
                    },
                    processResults: function (data, page) {
                      return { results: data.data };
                    },
                    
                    results: function (data) {
                        var newData = [];
                        $.each(data, function (index ,value) {
                            newData.push({
                                id: value.id,  //id part present in data
                                text: value.name,  //string to be displayed
                            });
                        });
                    },
                    
                    cache: true
                  },
                  escapeMarkup: function (markup) { return markup; },
                  minimumInputLength: 1,
                  templateResult: self.select2ThemeTemplate,
                  templateSelection: self.select2ThemeSelect
            });
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