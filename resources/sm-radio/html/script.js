$(function(){
    var click = document.createElement('audio');
    click.setAttribute('src', 'assets/click.mp3');
    click.volume = 0.2

    var status = false
    $(".toggleStatus").on('click', function(e){
        e.stopPropagation();
        e.stopImmediatePropagation();

        if (click.paused) {click.play();} else {click.currentTime=0}
        if (status == false) {
            $(".radio_off").hide();
            $(".radio_on").show();
            status = true;

            $(".tooltip_top:first").text("Turn Off");
            if ($(".channel_on").val() > 0) {
                $.post('http://sm-radio/joinChannel', JSON.stringify({channel:$(".channel_on").val()}))
            }
        } else {
            $(".radio_on").hide();
            $(".radio_off").show();
            status = false;

            $(".tooltip_top:first").text("Turn On");
            $.post('http://sm-radio/leaveChannel', JSON.stringify({}))
        }
    })

    var cvolume = 100
    var activeVolume = null
    var muted = false
    function changeActiveVolume(vol) {
        const listarray = $(".vlist").toArray();

        if (vol <= 0) {
            listarray[0].querySelector(".vlistdivon").className = "vlistdivmute";
            muted = true
            return
        } else if (muted) {
            listarray[0].querySelector(".vlistdivmute").className = "vlistdivon";
            muted = false
            return
        }

        if (activeVolume != null) {activeVolume.className = "vlistdiv"}
        for (i=1; i<11; i++) {
            if (vol/10 == i) {
                listarray[i-1].querySelector(".vlistdiv").className = "vlistdivon";
                activeVolume = listarray[i-1].querySelector(".vlistdivon")
            }
        }
    }
    changeActiveVolume(cvolume)

    $(".volumeUp").on('click', function(e){
        e.stopPropagation();
        e.stopImmediatePropagation();
        
        if (cvolume >= 100) return;
        if (click.paused) {click.play();} else {click.currentTime=0}
        cvolume = cvolume + 10
        vol = cvolume*0.01
        if (vol == 1) vol = 0.99; 
        $.post('http://sm-radio/setVolume', JSON.stringify({volume:vol}))
        changeActiveVolume(cvolume);
    })
    $(".volumeDown").on('click', function(e){
        e.stopPropagation();
        e.stopImmediatePropagation();

        if (cvolume <= 0) return;
        if (click.paused) {click.play();} else {click.currentTime=0}
        cvolume = cvolume - 10
        $.post('http://sm-radio/setVolume', JSON.stringify({volume:cvolume*0.01}))
        changeActiveVolume(cvolume);
    })

    $(document).on('keypress', 'input', function(e){
        if ($(".channel_on").is(":focus") && e.which == 13) {
            var inputVal = $(this).val();
            $(this).blur();

            if (inputVal > 0) {
                $.post('http://sm-radio/joinChannel', JSON.stringify({channel:inputVal}))
            }
        }
    })

    window.addEventListener('message', function(e){
        if (e.data.type == "display"){
            if (e.data.status == true) {
                $(".radio_off").css('opacity', '1');
                $(".radio_on").css('opacity', '1');
                $("#volumeVisual").css('opacity', '1');
            } else if (e.data.status == false) {
                $(".radio_off").css('opacity', '0');
                $(".radio_on").css('opacity', '0');
                $("#volumeVisual").css('opacity', '0');
            }
        }
    })

    document.onkeyup = function(data){
        if (data.which == 27) {
            $.post('http://sm-radio/close', JSON.stringify({}));
        }
    }

})