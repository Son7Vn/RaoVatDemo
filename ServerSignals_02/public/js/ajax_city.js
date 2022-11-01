
$(document).ready(function(){
    var url = "http://localhost:3000"
    $.post(url + "/city/listCity", function(listCitiesData){
                    if (listCitiesData.result == 1) {
                        $("#city_List").html("")
                        listCitiesData.messenger.forEach(element => {
                            $("#city_List").append(`
                                <li class="city" cityID="` + element._id + `">` + element.name + `</li>
                            `);
                        });
                    } else {
                        console.log("Error",listCitiesData.messenger)
                    }
                });
    // du lieu chet(lay ve tu ajax) nen phai them "on" vao moi bat duoc su kien:
    $(document).on("click",".city", function() {
        const txt = $(this).html()
        const id_City = $(this).attr("cityid")

        $("#update_City").val(txt)
        $("#hid_Txt").val(id_City)
        
    });
    $("#btn_Update").click(function() {
        const id = $("#hid_Txt").val()
        const txtU = $("#update_City").val()
        $.post(url + "/city/update", {id_City: id, newName: txtU }, function(newData) {
            if (newData.result == 1) {
                $.post(url + "/city/listCity", function(listCitiesData){
                    if (listCitiesData.result == 1) {
                        $("#city_List").html("")
                        listCitiesData.messenger.forEach(element => {
                            $("#city_List").append(`
                                <li class="city" cityID="` + element._id + `">` + element.name + `</li>
                            `);
                        });
                        $("#update_City").val("")
                    } else {
                        console.log("Error",listCitiesData.messenger)
                    }
                });
            } else {
                console.log(newData.messenger)
            }
        });
    });

    $("#btn_Delete").click(function() {
        const id = $("#hid_Txt").val()
        $.post(url + "/city/delete", {id_City: id}, function(newData) {
            if (newData.result == 1) {
                console.log(newData.messenger)
                $.post(url + "/city/listCity", function(listCitiesData){
                    if (listCitiesData.result == 1) {
                        $("#city_List").html("")
                        listCitiesData.messenger.forEach(element => {
                            $("#city_List").append(`
                                <li class="city" cityID="` + element._id + `">` + element.name + `</li>
                            `);
                        });
                    } else {
                        console.log("Error",listCitiesData.messenger)
                    }
                });
            } else {
                console.log(newData.messenger)
            }
        });
    });

});
