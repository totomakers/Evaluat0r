<templates>
    <div class="animated fadeIn" id="templates-body" hidden>
        <div class="row">
            <div class="col-lg-12">
                <h1>Modèles <small>- {templates.count} disponible(s)</small></h1>
                <hr>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-8">
                <div class="row">
                    <div class="col-lg-12" id="templates-alert-box">
                    </div>
                </div>
                <div class="table" id="templates-data">
                    <table class="table table-striped">
                        <thead>
                            <th>Nom</th>
                            <th class="text-right">Thèmes</th>
                            <th class="text-right">Actions</th>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input type="text" class="form-control" id="template-add-name" placeholder="Nom"></input></td>
                                <td></td>
                                <td class="text-right"><button id="template-add-button" class="btn btn-success btn-lg" onclick={template_add}><i id="template-add-button-ico" class="fa fa-plus fa-lg"></i></button></td>
                            </tr>
                            <tr each={ templates }>
                                <td>
                                    <span class="radio radio-primary">
                                        <input type="radio" name="currentModel" id="template-radio-name-{id}" value="{id}" class="template-radio" onclick={template_themes_load}>
                                        <label for="template-radio-name-{id}">{name}</label>
                                    </span>
                                </td>
                                <td class="text-right v-align">{theme_count}</td>
                                <td class="text-right v-align"><a href="" onclick={template_delete}><i data-toggle="tooltip" data-placement="top" title="Supprimer" class="fa fa-red fa-trash fa-lg"/></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="row">
                    <div class="col-lg-12 text-center" id="templates-pagination-box">
                </div>
            </div>
            </div>
            <div class="col-lg-4" class="animated fadeIn">
                <templates_themes template={opts.template}>
                </templates_themes>
            </div>
        </div>
    </div>
    
    <script>
        var self = this;
        self.templates = [];
        loader.show();
        
        this.on('mount',function() {
            opts.template.getAll(opts.page.id);
        });
        
        //---------------
        //UTILS ---------
        //---------------
        
        var enableForm = function(enable, clear)
        {
            var name = $('#template-add-name');
            var ongoingPrc = $('#template-add-ongoing-prc');
            var acceptedPrc = $('#template-add-accepted-prc');
            var buttonAdd = $('#template-add-button');
            var buttonAddIcon = $('#template-add-button-ico');
            
            if(enable == true)
            {
                name.removeAttr('disabled');
                ongoingPrc.removeAttr('disabled');
                acceptedPrc.removeAttr('disabled');
                buttonAdd.removeAttr('disabled');
                
                buttonAddIcon.addClass('fa-plus');
                buttonAddIcon.removeClass('fa-spinner');
                buttonAddIcon.removeClass('fa-spin');
            }
            else
            {
                name.attr('disabled', 'disabled');
                ongoingPrc.attr('disabled', 'disabled');
                acceptedPrc.attr('disabled', 'disabled');
                buttonAdd.attr('disabled', 'disabled');
                
                buttonAddIcon.removeClass('fa-plus');
                buttonAddIcon.addClass('fa-spinner fa-spin');
            }
            
            if(clear)
            {
                name.val('');
                ongoingPrc.val('');
                acceptedPrc.val('');
            }
        };
        
        //---------------
        //SIGNAL --------
        //---------------
        
        var pageClick = function(event, page)
        {
            var templatesData= $('#templates-data');
            templatesData.addClass("animated fadeOutLeft");
            opts.page.id = page;
            riot.route.stop();
            riot.route('templates/all/'+page);
            riot.route.start();
            riot.route(router);

            opts.template.getAll(page);
        }
        
        template_delete(e) {
            opts.template.delete(e.item.id);
        }
        
        template_add(e){
            enableForm(false, false);
            
            var name = $('#template-add-name');
            var ongoingPrc = $('#template-add-ongoing-prc');
            var acceptedPrc = $('#template-add-accepted-prc');
            
            opts.template.add({name: name.val(), ongoing_prc: ongoingPrc.val(), accepted_prc: acceptedPrc.val() });
        }
        
        template_themes_load(e){
           template.trigger('templates_themes_loading');
           template.getThemes(e.item.id);
        }
                    
        //---------------
        //EVENT ---------
        //---------------
        
        opts.template.on('template_getAll', function(json) 
        {
            loader.hide();
            
            //---------
            self.templates = json.data.data;
            self.templates.sort(opts.template.sortByName);
            self.templates.count = json.data.total;
            self.update();
            
            var templatesData = $('#templates-data');
            templatesData.one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function()
            {
                templatesData.removeClass("animated fadeOutLeft");
                
                templatesData.addClass("animated fadeInLeft");
            });
            
            if($('.template-radio').length > 0)
                $('.template-radio')[0].click();
            
            refreshTooltip();
            pagination.refreshPagination('#templates-pagination-box', '#templates-pagination', json.data, pageClick);
            
            $('#templates-body').show();
            loader.hide();
        });  
        
        opts.template.on('template_refreshAll', function(json) 
        {
            self.templates = json.data.data;
            self.templates.sort(opts.template.sortByName);
            self.templates.count = json.data.total;
            self.update();
           
            refreshTooltip();
            pagination.refreshPagination('#themes-pagination-box', '#themes-pagination', json.data, pageClick);
            
             if($('.template-radio').length > 0)
                $('.template-radio')[0].click();
             else
                 template.trigger('templates_themes_hide');
        });

        opts.template.on('template_delete', function(json)
        {
             if(json.error)
                alert.show('#templates-alert-box', 'danger', json.message);
            else
                alert.show('#templates-alert-box', 'success', json.message);
            opts.template.refreshAll(opts.page.id);  
        });
        
        opts.template.on('template_add', function(json)
        {
            if(json.error == true)
                alert.show('#templates-alert-box', 'danger', json.message);
            else
            {
                alert.show('#templates-alert-box', 'success', json.message);
                opts.template.refreshAll(opts.page.id);  
            }

            enableForm(true, (json.error == false));
        });
        
    </script>
</templates>