<templates>
    <div class="animated fadeIn">
        <div class="row">
            <div class="col-lg-12">
                <h1>Modèles <small>- {templates.count} modèle(s)</small></h1>
                <hr>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-7">
                <div class="row">
                    <div class="col-lg-12" id="templates-alert-box">
                    </div>
                </div>
                <div class="table" id="templates-data">
                    <table class="table table-striped">
                        <thead>
                            <th></th>
                            <th>Nom</th>
                            <th>Durée du test</th>
                            <th>Admis: % requis</th>
                            <th>En cours d'acquisition: % requis</th>
                            <th>Thèmes</th>
                            <th>Actions</th>
                        </thead>
                        <tbody>
                            <tr>
                                <td></td>
                                <td><input type="text" class="form-control" id="template-add-name" placeholder="Nom"></input></td>
                                <td>
                                    <div class="input-group clockpicker">
                                        <input type="text" class="form-control" value="00:00" id="template-add-duration">
                                        <span class="input-group-addon"><span class="fa fa-clock-o"></span></span>
                                    </div>
                                </td>
                                <td><input type="text" class="form-control" id="template-add-accepted-prc" placeholder="80"></input></td>
                                <td><input type="text" class="form-control" id="template-add-ongoing-prc" placeholder="50"></input></td>
                                <td></td>
                                <td><button id="template-add-button" class="btn btn-success btn-lg" onclick={template_add}><i id="template-add-button-ico" class="fa fa-plus fa-lg"></i></button></td>
                            </tr>
                            <tr each={ templates }>
                                <td><input type="radio" name="currentModel" value="{id}" class="template-radio" onclick={template_themes_load}></td>
                                <td>{name}</td>
                                <td class="text-right">{duration}</td>
                                <td class="text-right"><span class="text-success">±{accepted_prc}%</span></td>
                                <td class="text-right"><span class="text-warning">±{ongoing_prc}%</span></td>
                                <td class="text-right"></td>
                                <td class="text-center"><a href="" onclick={template_delete}><i data-toggle="tooltip" data-placement="top" title="Supprimer" class="fa fa-red fa-trash fa-lg"/></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="row">
                    <div class="col-lg-12 text-center" id="templates-pagination-box">
                </div>
            </div>
            </div>
            <div class="col-lg-5" class="animated fadeIn">
                <templates_themes>
                </templates_themes>
            </div>
        </div>
    </div>
    
    <script>
        var self = this;
        self.templates = [];
        loader.show();
        
        this.on('mount',function() {
            $('.clockpicker').clockpicker({
                    donetext: 'Valider',
                    default: '00:00',
                    placement: 'bottom',
                    //align: 'top',
            });   
            
            opts.template.getAll(opts.page.id);

            loader.hide();            
        });
        
        //---------------
        //UTILS ---------
        //---------------
        
        var enableForm = function(enable, clear)
        {
            var name = $('#template-add-name');
            var duration = $('#template-add-duration');
            var ongoingPrc = $('#template-add-ongoing-prc');
            var acceptedPrc = $('#template-add-accepted-prc');
            var buttonAdd = $('#template-add-button');
            var buttonAddIcon = $('#template-add-button-ico');
            
            if(enable == true)
            {
                name.removeAttr('disabled');
                duration.removeAttr('disabled');
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
                duration.attr('disabled', 'disabled');
                ongoingPrc.attr('disabled', 'disabled');
                acceptedPrc.attr('disabled', 'disabled');
                buttonAdd.attr('disabled', 'disabled');
                
                buttonAddIcon.removeClass('fa-plus');
                buttonAddIcon.addClass('fa-spinner fa-spin');
            }
            
            if(clear)
            {
                name.val('');
                duration.val('');
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
            templates.addClass("animated slideOutRight");
            opts.page.id = page;

            opts.template.getAll(page);
        }
        
        template_delete(e) {
            opts.template.delete(e.item.id);
        }
        
        template_add(e){
            enableForm(false, false);
            
            var name = $('#template-add-name');
            var duration = $('#template-add-duration');
            var ongoingPrc = $('#template-add-ongoing-prc');
            var acceptedPrc = $('#template-add-accepted-prc');
            
            opts.template.add({name: name.val(), duration: duration.val(), ongoing_prc: ongoingPrc.val(), accepted_prc: acceptedPrc.val() });
        }
        
        template_themes_load(e){
           
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
                templatesData.removeClass("animated slideOutRight");
                templatesData.addClass("animated slideInLeft");
            });
            
            if($('.template-radio').length > 0)
                $('.template-radio')[0].setAttribute("checked", "checked"); //check the first
            
            refreshTooltip();
            pagination.refreshPagination('#templates-pagination-box', '#templates-pagination', json.data, pageClick);
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
                $('.template-radio')[0].setAttribute("checked", "checked"); //check the first
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