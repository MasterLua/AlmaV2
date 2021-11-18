var moneyactuelle = 0;
var dirtymoneyactuelle = 0;
var jobactuelle = "aucun";
var jobrankactuelle = "";
var crewactuelle = "aucun";
var crewrankactuelle = "";

// function formatNumber(num) {
//     return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1 ')
//   }

$(function () {
    window.addEventListener("message", function (event) {
        var mess = event.data;

        if (typeof mess.initialise !== "undefined") {
            $("#money .infos").html(mess.money + "$");
            $("#dirty-money .infos").html(mess.dirtymoneyinfo + "$");
            $("#job .infos").html('<span class="bold">' + mess.job + "</span>" + mess.jobrank);
            $("#crew .infos").html('<span class="bold">' + mess.crew + "</span>" + mess.crewrank);
            $("#rank .infos").html('<span class="bold">Niveaux ' + mess.rank + "</span>");
            $("#character-name").html(mess.name);
            rankactuelle = mess.rank;
            moneyactuelle = mess.money;
            dirtymoneyactuelle = mess.dirtymoneyinfo;
            jobactuelle = mess.job;
            jobrankactuelle = mess.jobrank;
            crewactuelle = mess.crew;
            crewrankactuelle = mess.crewrank;
        }

        if (typeof mess.moneyinfo !== "undefined") {
            $("#money .infos").html(mess.moneyinfo + "$");
            moneyactuelle = mess.moneyinfo;
        }

        if (typeof mess.dirtymoneyinfo !== "undefined") {
            $("#dirty-money .infos").html(mess.dirtymoneyinfo + "$");
            dirtymoneyactuelle = mess.dirtymoneyinfo;
        }

        if (typeof mess.jobinfo !== "undefined") {
            //a modifier, ajout du rank
            $("#job .infos").html('<span class="bold">' + mess.jobinfo + "</span>" + mess.jobrank);
            jobactuelle = mess.jobinfo;
            jobrankactuelle = mess.jobrank;
        }

        if (typeof mess.rank !== "undefined") {
            $("#rank .infos").html('<span class="bold">Niveaux ' + mess.rank + "</span>");
            rankactuelle = mess.rank;
        }

        if (typeof mess.crewinfo !== "undefined") {
            $("#crew .infos").html('<span class="bold">' + mess.crewinfo + "</span>" + mess.crewrank);
            crewactuelle = mess.crewinfo;
            crewrankactuelle = mess.crewrank;
        }

        if (typeof mess.hud !== "undefined") {
            if (mess.hud == true) {
                $("#money").fadeIn();
                $("#dirty-money").fadeIn();
                $("#job").fadeIn();
                $("#crew").fadeIn();
                $("#rank").fadeIn();
                $("#character-name").fadeIn();
                $("#name-border").fadeIn();
                $("#name-row").fadeIn();
                $("#infos-container").fadeIn();
            } else {
                $("#money").fadeOut();
                $("#dirty-money").fadeOut();
                $("#job").fadeOut();
                $("#crew").fadeOut();
                $("#rank").fadeOut();
                $("#character-name").fadeOut();
                $("#name-border").fadeOut();
                $("#name-row").fadeOut();
                $("#infos-container").fadeOut();
            }
        }

        // if (typeof mess.hunger !== "undefined") {
        //     $("#hunger").css("width", mess.hunger + "%");
        // }

        // if (typeof mess.thirst !== "undefined") {
        //     $("#thirst").css("width", mess.thirst + "%");
        // }

        // if (typeof mess.fuel !== "undefined") {
        //     if (mess.fuel !== false) {
        //         $("#fuel").fadeIn();
        //         $("#hungerFuel2").fadeIn();
        //         $("#fuel").css("width", mess.fuel + "%");
        //     } else {
        //         $("#fuel").fadeOut();
        //         $("#hungerFuel2").fadeOut();
        //     }
        // }
    });
});
