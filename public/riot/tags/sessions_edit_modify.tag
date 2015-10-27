<session_edit_modify>
    <div class="row">
        <div class="col-lg-12">
            <h2>Session</h2>
            <hr>
        </div>
    </div>
   <form class="form-horizontal">
      <div class="form-group">
        <label for="session-name" class="col-lg-2 control-label">Nom</label>
        <div class="col-lg-10">
          <input type="text" class="form-control" id="session-name">
        </div>
      </div>
      
      <div class="form-group">
        <label for="session-start" class="col-lg-2 control-label">Début</label>
        <div class="col-lg-4">
            <div class='input-group date' id="datetime-picker-start">
                    <input type='text' class="form-control" />
                    <span class="input-group-addon">
                        <span class="fa fa-calendar"></span>
                    </span>
            </div>
        </div>
         <label for="session-end" class="col-lg-2 control-label">Fin</label>
        <div class="col-lg-4">
            <div class='input-group date' id="datetime-picker-end">
                    <input type='text' class="form-control" />
                    <span class="input-group-addon">
                        <span class="fa fa-calendar"></span>
                    </span>
            </div>
        </div>
      </div>
       <div class="form-group">
        <label for="session-timer" class="col-lg-2 control-label">Durée</label>
        <div class="col-lg-3">
            <div class="input-group clockpicker">
                <input type="text" class="form-control" value="00:00" id="session-timer">
                <span class="input-group-addon"><span class="fa fa-clock-o"></span></span>
            </div>
        </div>
      </div>
      <div class="form-group text-right">
        <div class="col-lg-offset-2 col-lg-10">
          <button type="submit" class="btn btn-default btn-success">Valider</button>
        </div>
      </div>
    </form>
<script>
    this.on('mount',function() {
        $('#datetime-picker-start').datetimepicker({
           icons: {
                    time: "fa fa-clock-o",
                    date: "fa fa-calendar",
                    up: "fa fa-arrow-up",
                    down: "fa fa-arrow-down"
                },
            format: 'DD/MM/YYYY',    
        });
        
        $('#datetime-picker-end').datetimepicker({
           icons: {
                    time: "fa fa-clock-o",
                    date: "fa fa-calendar",
                    up: "fa fa-arrow-up",
                    down: "fa fa-arrow-down"
                },
            format: 'DD/MM/YYYY',    
        });
        
        $('.clockpicker').clockpicker({
                    //donetext: 'Valider',
                    default: '00:00',
                    placement: 'bottom',
                    autoclose : true,
                    align: 'top',
            });   
    });   
</script>
</session_edit_modify>

