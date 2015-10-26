<templates_themes>
    <div id="subloader" class="text-center" hidden>
        <i class="fa fa-spinner fa-spin fa-3x"/>
    </div>
    <div id="templates-themes-content" class="animated fadeIn" hidden>
        <div class="row">
            <div class="col-lg-12">
                <h2><small>{themes.length} thème(s)</small></h1>
            </div>
        </div>
        <div class="row">
            <div class="row">
                <div class="col-lg-12" id="templates-themes-alert-box">
                </div>
            </div>
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
                                <td class="col-md-6"><select class="form-control" id="template-theme-theme-name" placeholder="" style="width:100%"></select></td>
                                <td><input type="text" class="form-control" id="template-theme-questions-count" placeholder=""></input></td>
                                <td><button id="model-theme-add-button" class="btn btn-success btn-lg" onclick={template_themes_add}><i id="model_theme_button_ico" class="fa fa-plus fa-lg"></i></button></td>
                            </tr>
                            <tr each={themes}>
                                <td><a href="#themes/edit/{ pivot.theme_id }">{name}</a></td>
                                <td>{ pivot.question_count } questions</td>
                                <td class="text-center"><a href="" onclick={template_theme_delete}><i data-toggle="tooltip" data-placement="top" title="Supprimer" class="fa fa-red fa-trash fa-lg"/></a></td>
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
        self.templateId;
        
        this.on('mount', function(){
            //select2
            $("#template-theme-theme-name").select2({
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
        
        //-----------
        //UTILS -----
        //-----------
        
        self.select2ThemeTemplate = function(result) 
        {
            if (result.loading) return "Chargement...";
        
            var markup = '<div>'+result.name+'</div>'
            return markup;
        }
          
        self.select2ThemeSelect = function(selection) {
            return selection.name;
        }
        
        self.enableForm = function(enable, clear)
        {
            var selectName = $('#template-theme-theme-name');
            var questionCount = $('#template-theme-questions-count');
            var buttonAdd = $('#model-theme-add-button');
            var buttonAddIcon = $('#model_theme_button_ico');
            
            if(enable == true)
            {
                selectName.removeAttr('disabled');
                questionCount.removeAttr('disabled');
                buttonAdd.removeAttr('disabled');
                
                buttonAddIcon.addClass('fa-plus');
                buttonAddIcon.removeClass('fa-spinner');
                buttonAddIcon.removeClass('fa-spin');
            }
            else
            {
                selectName.attr('disabled', 'disabled');
                questionCount.attr('disabled', 'disabled');
                buttonAdd.attr('disabled', 'disabled');
                
                buttonAddIcon.removeClass('fa-plus');
                buttonAddIcon.addClass('fa-spinner fa-spin');
            }
            
            if(clear == true)
            {
                questionCount.val('');
            }
        }
        
        //------------
        //SIGNALS ----
        //------------
        
        template_themes_add(e){
            var selectName = $('#template-theme-theme-name');
            var questionCount = $('#template-theme-questions-count');
            
            self.enableForm(false, false);
            opts.template.addTheme(self.templateId, {'theme_id': selectName.val(), 'question_count': questionCount.val()});
        }
        
        template_theme_delete(e){
            opts.template.removeTheme(self.templateId, e.item.id);
        }
        
        
        //----------
        //EVENTS ---
        //----------
        
        opts.template.on('template_themes', function(json)
        {
            self.themes = json.data.data;
            self.templateId = json.data.from;
            self.update();
        
            loader.hide('#subloader');
            $('#templates-themes-content').show();
 
            
            refreshTooltip();
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
             
        opts.template.on('template_add_theme', function(json)
        {
            if(json.error == false)
            {
                alert.show('#templates-themes-alert-box', 'success', json.message);
                opts.template.getThemes(json.data.template.id);
            }
            else
                alert.show('#templates-themes-alert-box', 'danger', json.message);
            
            self.enableForm(true, json.error == false);
        });
        
        opts.template.on('template_remove_theme', function(json)
        {
            if(json.error == false)
            {
                alert.show('#templates-themes-alert-box', 'success', json.message);    
                opts.template.getThemes(self.templateId);
            }
            else
                alert.show('#templates-themes-alert-box', 'danger', json.message);
                
                
             self.enableForm(true, json.error == false);
        });
        
    </script>
</templates_themes>