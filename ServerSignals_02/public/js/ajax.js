$(document).ready(function(){
    
    var url = "http://localhost:3000"

    $("#btnAddCity").click(function() {
        $.post(url+"/city/add", {Name: $("#cityName").val()}, function(cityData) {
            console.log(cityData);
            if (cityData.result == 1) {
                $.post(url + "/city/listCity", function(listCitiesData){
                    if (listCitiesData.result == 1) {
                        $("#city_List").html("")
                        listCitiesData.messenger.forEach(element => {
                            $("#city_List").append(`
                                <li cityID="` + element._id + `">` + element.name + `</li>
                            `);
                        });
                    } else {
                        console.log("Error",listCitiesData.messenger)
                    }
                });
            } else {
                console.log("Error!")
            }
        });
    }) 

})