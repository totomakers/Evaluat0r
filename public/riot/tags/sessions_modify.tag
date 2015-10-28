<sessions_modify>
    <div class="animated fadeIn" id="session-edit-content" hidden>
        <div class="row">
            <div class="col-lg-12 animated slideInDown">
                <h2><a data-toggle="tooltip" data-placement="bottom" title="Retour" href="javascript:history.back()"><i class="fa fa-chevron-left"></i></a> { session.name }</h2>
                <hr>
            </div>
        </div>
        <div id="session-modify-alert-box"></div>
        <form class="form-horizontal" onsubmit={putSession}>
          <div class="form-group">
            <label for="session-name" class="col-lg-2 control-label">Nom</label>
            <div class="col-lg-10">
              <input type="text" class="form-control" id="session-name" value={session.name}>
            </div>
          </div>
          <div class="form-group">
            <label for="session-date-start" class="col-lg-2 control-label">Date début</label>
            <div class="col-lg-4">
                <div class='input-group date' id="datetime-picker-start">
                        <input type='text' class="form-control" id="session-date-start" value={dateFormatFr(session.start_date)}/>
                        <span class="input-group-addon">
                            <span class="fa fa-calendar"></span>
                        </span>
                </div>
            </div>
             <label for="session-date-end" class="col-lg-2 control-label">Date de fin</label>
            <div class="col-lg-4">
                <div class='input-group date' id="datetime-picker-end">
                        <input id="session-date-end" type='text' class="form-control" value={dateFormatFr(session.end_date)} />
                        <span class="input-group-addon">
                            <span class="fa fa-calendar"></span>
                        </span>
                </div>
            </div>
          </div>
           <div class="form-group">
            <label for="session-duration" class="col-lg-2 control-label">Durée</label>
            <div class="col-lg-3">
                <div class="input-group clockpicker">
                    <input type="text" class="form-control" id="session-duration" value={session.duration}>
                    <span class="input-group-addon"><span class="fa fa-clock-o"></span></span>
                </div>
            </div>
          </div>
          <div class="form-group text-right">
            <div class="col-lg-offset-2 col-lg-10">
              <button id="button-modify" type="submit" class="btn btn-default btn-primary"><i id="button-modify-ico" class="fa fa-pencil"></i> Modifier</button>
            </div>
          </div>
        </form>
    </div>
    <script>
        var self = this;
        self.session = {};
        
        this.on('mount',function() 
        {
            initDatepicker('#datetime-picker-start');
            initDatepicker('#datetime-picker-end');
            initClockpicker();
            
            opts.session.get(opts.page.id);
        });
        
            
        //--------
        //UTILS --
        //--------
        
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
        
        var enableForm = function(enable)
        {
            var name = $('#session-name');
            var startDate = $('#session-date-start');
            var endDate = $('#session-date-end');
            var duration = $('#session-duration');
            
            var buttonModify = $('#button-modify');
            var buttonModifyIco = $('#button-modify-ico');
            
            if(enable == true)
            {
                name.removeAttr('disabled');
                startDate.removeAttr('disabled');
                endDate.removeAttr('disabled');
                duration.removeAttr('disabled');
                buttonModify.removeAttr('disabled');
                
                buttonModifyIco.addClass('fa-pencil');
                buttonModifyIco.removeClass('fa-spinner');
                buttonModifyIco.removeClass('fa-spin');
            }
            else
            {
                name.attr('disabled', 'disabled');
                startDate.attr('disabled', 'disabled');
                endDate.attr('disabled', 'disabled');
                duration.attr('disabled', 'disabled');
                buttonModify.attr('disabled', 'disabled');
                
                buttonModifyIco.removeClass('fa-pencil');
                buttonModifyIco.addClass('fa-spinner fa-spin');
            }
        }
        
        //--------
        //SIGNAL --
        //--------
        
        putSession(e){
            enableForm(false);
            
            var name = $('#session-name').val();
            var start_date = $('#session-date-start').val();
            var end_date = $('#session-date-end').val();
            var duration = $('#session-duration').val();
            var params = { 'name' : name, 'start_date': start_date, 'end_date': end_date, 'duration': duration };
            
            opts.session.update(opts.page.id, params);
        }
        
        //----------
        //SLOTS ----
        //----------
        
        opts.session.on('session_get', function(json)
        {
            self.session = json.data;
            self.update();
            
            $('#session-edit-content').show();
            loader.hide();
        });
        
        opts.session.on('session_update', function(json)
        {
            if(json.error == true)
                    alert.show('#session-modify-alert-box', 'danger', json.message);
            else
            {
                alert.show('#session-modify-alert-box', 'success', json.message);
                self.session = json.data;
                self.update();
            }

            enableForm(true);
        });
    </script>
</sessions_modify>

