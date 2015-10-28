<sessions>
    <div class="animated fadeIn" id="sessions-body" hidden>
        <div class="row">
            <div class="col-lg-12">
                <h1>Sessions <small> - { sessions.count } disponible(s)</small></h1>
                <hr>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12" id="alert-box"></div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="table">
                    <table id="sessions-data" class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Nom session</th>
                                <th>Début</th>
                                <th>Fin</th>
                                <th>Durée</th>
                                <th>Admis(%)</th>
                                <th>En cours(%)</th>
                                <th class="text-right">Questions</th>
                                <th class="text-right">Candidats</th>
                                <th class="text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input type="text" class="form-control" id="sessions-add-name" placeholder="Nom"></input></td>
                                <td>   
                                    <div class='input-group date' id="datepicker-start">
                                        <input type='text' class="form-control" id="sessions-add-start-date"/>
                                        <span class="input-group-addon">
                                        <span class="fa fa-calendar"></span></span>
                                    </div>
                                </td>
                                <td>  
                                    <div class='input-group date' id="datepicker-end">
                                        <input type='text' class="form-control" id="sessions-add-end-date"/>
                                        <span class="input-group-addon">
                                        <span class="fa fa-calendar"></span></span>
                                    </div>
                                </td>
                                <td>
                                    <div class="input-group clockpicker">
                                        <input type="text" class="form-control" value="00:00" id="sessions-add-duration"/>
                                        <span class="input-group-addon"><span class="fa fa-clock-o"></span></span>
                                    </div>
                                </td>
                                <td>
                                    <div class='input-group'>
                                        <input type='text' class="form-control" id="sessions-add-accepted-prc"/>
                                        <span class="input-group-addon">%</span>
                                    </div>
                                </td>
                                <td>
                                    <div class='input-group'>
                                        <input type='text' class="form-control" id="sessions-add-ongoing-prc"/>
                                        <span class="input-group-addon">%</span>
                                    </div>
                                </td>
                                <td></td>
                                <td></td>
                                <td class="text-right"><button id="sessions-add-button" class="btn btn-success btn-lg" onclick={session_add}><i id="sessions-add-button-ico" class="fa fa-plus fa-lg"></i></button></td>
                            </tr>
                            <tr each={ sessions }>
                                <td>{name}</td>
                                <td>{ dateFormatFr(start_date) }</td>
                                <td>{ dateFormatFr(end_date)}</td>
                                <td>{(duration == '00:00:00') ? 'Illimité' : duration }</td>
                                <td class="text-right v-align"><span class="text-success">±{accepted_prc}%</span></td>
                                <td class="text-right v-align"><span class="text-warning">±{ongoing_prc}%</span></td>
                                <td class="text-right">{question_count}</td>
                                <td class="text-right">{candidate_count}</td>
                                <td class="text-right">
                                    <a href="#sessions/edit/{id}"><i data-toggle="tooltip" data-placement="top" title="Editer" class="fa fa-pencil fa-lg"></i></a>
                                    &nbsp;&nbsp;
                                    <a href="" onclick={session_delete}><i data-toggle="tooltip" data-placement="top" title="Supprimer" class="fa fa-red fa-trash fa-lg"/></a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 text-center" id="sessions-pagination-box">
            </div>
        </div>
    </div>
    
    <script>
        var self = this;
        loader.show();
        
        self.sessions = [];
        
         this.on('mount',function() {
            opts.session.getAll(opts.page.id);
            
            initDatepicker('#datepicker-start');
            initDatepicker('#datepicker-end');
            initClockpicker();
        });
        
        //---------------
        //SIGNALS -------
        //---------------
        
        session_add(e){
            var name = $('#sessions-add-name').val();
            var start_date = $('#sessions-add-start-date').val();
            var end_date = $('#sessions-add-end-date').val();
            var duration = $('#sessions-add-duration').val();
            var accepted = $('#sessions-add-accepted-prc').val();
            var ongoing = $('#sessions-add-ongoing-prc').val();
            
            var params = { 'name' : name, 'start_date': start_date, 'end_date': end_date, 'duration': duration, 'accepted_prc':accepted, 'ongoing_prc':ongoing };
            opts.session.add(params);
            enableForm(false, false);
        }
        
        session_delete(e){
            opts.session.delete(e.item.id);
        }
        
        //---------------
        //UTILS ---------
        //---------------
        
        var enableForm = function(enable, clear)
        {
            var name = $('#sessions-add-name');
            var start_date = $('#sessions-add-start-date');
            var end_date = $('#sessions-add-end-date');
            var duration = $('#sessions-add-duration');
            var accepted = $('#sessions-add-accepted-prc');
            var ongoing = $('#sessions-add-ongoing-prc');
            
            var buttonAdd = $('#sessions-add-button');
            var buttonAddIcon = $('#sessions-add-button-ico');
            
            if(enable == true)
            {
                name.removeAttr('disabled');
                start_date.removeAttr('disabled');
                end_date.removeAttr('disabled');
                duration.removeAttr('disabled');
                accepted.removeAttr('disabled');
                ongoing.removeAttr('disabled');
                buttonAdd.removeAttr('disabled');
                
                buttonAddIcon.addClass('fa-plus');
                buttonAddIcon.removeClass('fa-spinner');
                buttonAddIcon.removeClass('fa-spin');
                
            }
            else
            {
                name.attr('disabled', 'disabled');
                start_date.attr('disabled', 'disabled');
                end_date.attr('disabled', 'disabled');
                duration.attr('disabled', 'disabled');
                accepted.attr('disabled', 'disabled');
                ongoing.attr('disabled', 'disabled');
                buttonAdd.attr('disabled', 'disabled');
                
                buttonAddIcon.removeClass('fa-plus');
                buttonAddIcon.addClass('fa-spinner fa-spin');
            }
            
            if(clear == true)
            {
                name.val('');
                duration.val('00:00');
                accepted.val('');
                ongoing.val('');
            }
        }
        
        var pageClick = function(event, page)
        {
            var sessionsData= $('#sessions-data');
            sessionsData.addClass("animated fadeOutLeft");
            opts.page.id = page;
            riot.route.stop();
            riot.route('sessions/all/'+page);
            riot.route.start();
            riot.route(router);

            opts.sessions.getAll(page);
        }
        
        var initDatepicker = function(selector)
        {
            var yesterday = new Date();
            yesterday.setDate(yesterday.getDate()-1);

             $(selector).datetimepicker({
               icons: {
                        time: "fa fa-clock-o",
                        date: "fa fa-calendar",
                        up: "fa fa-arrow-up",
                        down: "fa fa-arrow-down"
                    },
                locale: 'fr',
                format: 'DD/MM/YYYY',    
                minDate: yesterday,
                disabledDates: [yesterday],
                defaultDate : new Date(),
            });
        }
        
        var initClockpicker = function()
        {
              $('.clockpicker').clockpicker({
                    //donetext: 'Valider',
                    default: '00:00',
                    placement: 'bottom',
                    autoclose : true,
                    //align: 'top',
            });   
        }
        
        //---------------
        //EVENT ---------
        //---------------
        
        opts.session.on('session_getAll', function(json)
        {
            self.sessions = json.data.data;
            self.sessions.count = json.data.total;
            self.update();
            
            refreshTooltip();
            pagination.refreshPagination('#sessions-pagination-box', '#sessions-pagination', json.data, pageClick);
            
            $('#sessions-body').show();
            loader.hide();
        });
        
        opts.session.on('session_add', function(json)
        {
            if(json.error == true)
                alert.show('#alert-box', 'danger', json.message);
            else
            {
                alert.show('#alert-box', 'success', json.message);
                opts.session.refreshAll(opts.page.id);
            }
            
            enableForm(true, (json.error == false));
        });
        
        opts.session.on('session_refreshAll', function(json)
        {
            self.sessions = json.data.data;
            self.sessions.count = json.data.total;
            self.update();
            
            refreshTooltip();
            pagination.refreshPagination('#sessions-pagination-box', '#sessions-pagination', json.data, pageClick);
        });
        
        opts.session.on('session_delete', function(json)
        {
            if(json.error == true)
                alert.show('#alert-box', 'danger', json.message);
            else
            {
                alert.show('#alert-box', 'success', json.message);
                opts.session.refreshAll(opts.page.id);
            }
        });
        
    </script>
</sessions>