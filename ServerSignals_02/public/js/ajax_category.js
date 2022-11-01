$(document).ready(() => {

    const url = "http://localhost:3000"

    const urlListCate = url + "/Cate/findAll"
    $.post(urlListCate, (dataListCateFrSer) => {
        const resultTrue = dataListCateFrSer.result == 1
        const dataListCate = dataListCateFrSer.messenger
        if (resultTrue) {
            const idListCate = "#list_cate";
            $(idListCate).html("");
            dataListCate.forEach(element => {
                const attImgList = element.imageName
                const idCate = element._id
                $(idListCate).append(`
                    <li class=Cate id=`+idCate+` srcImg=`+attImgList+`>`+element.name+`</li>
                `);
            });
        } else {
            alert("Error to show List Cate")
        }
    });

    $("#addFileIMG").change(()=> {
        var data = new FormData();
            jQuery.each(jQuery('#addFileIMG')[0].files, function(i, file) {
                console.log("avatar");
                data.append("avatar", file);
            });

            jQuery.ajax({
                url: url + "/uploadTest",
                data: data,
                cache: false,
                contentType: false,
                processData: false,
                method: 'POST',
                type: 'POST', // For jQuery < 1.9
                success: function(data){
                    if(data.result==1){
                        // $("#imgAvatar").attr("src","upload/" + data.file);
                        
                        const valImg = url + "/upload/" + data.file
                        $("#imgtest").attr("src",valImg)
                        $("#file_ImgCate").val(data.file)
                        $("#hid_ImgName").val(data.file)
                    }else{
                        alert("Upload fail!");
                    }
                }
            });
    })
    $("#Add_Cate").click(()=> {
        const urlRouter = url + "/Cate/Add"
        const name = $("#TxtCategory").val()
        const imgName = $("#file_ImgCate").val()
        $.post(urlRouter, {name: name, imgName: imgName}, (dataAddNewCate) => {
            const resultTruee = dataAddNewCate.result == 1
            if(resultTruee){
                $.post(urlListCate, (dataListCateFrSer) => {
                    const resultTrue = dataListCateFrSer.result == 1
                    const dataListCate = dataListCateFrSer.messenger
                    if (resultTrue) {
                        const idListCate = "#list_cate";
                        $(idListCate).html("");
                        dataListCate.forEach(element => {
                            const attImgList = element.imageName
                            const idCate = element._id
                            $(idListCate).append(`
                                <li class=Cate id=`+idCate+` srcImg=`+attImgList+`>`+element.name+`</li>
                            `);
                        });
                        $("#TxtCategory").val("")
                    } else {
                        alert("Error to show List Cate")
                    }
                });
            } else {
                alert("Add Failed!")
            }
        });
    });

    $(document).on("click",".Cate",function() {
        const txtCate = $(this).html()
        const imaName = $(this).attr("srcImg")
        const imgLink = url + "/upload/" + imaName
        const cate_ID = $(this).attr("id")
        
        $("#changeTxt").val(txtCate)
        $("#imgtest").attr("src",imgLink)
        $("#hid_ImgName").val(imaName)
        $("#hid_ID").val(cate_ID)
    })

    $("#btn_changeCate").click(function(){

        const urlEdit = url + "/Cate/Edit"
        const idCate = $("#hid_ID").val()
        const imgNameCate = $("#hid_ImgName").val()
        const nameCate = $("#changeTxt").val()

        $.post(urlEdit, {idCate: idCate, nameCate: nameCate, imgNameCate: imgNameCate}, function(dataEdit){
            const resultTruee = dataEdit.result == 1
            if(resultTruee){
                $.post(urlListCate, (dataListCateFrSer) => {
                    const resultTrue = dataListCateFrSer.result == 1
                    const dataListCate = dataListCateFrSer.messenger
                    if (resultTrue) {
                        const idListCate = "#list_cate";
                        $(idListCate).html("");
                        dataListCate.forEach(element => {
                            const attImgList = element.imageName
                            const idCate = element._id
                            $(idListCate).append(`
                                <li class=Cate id=`+idCate+` srcImg=`+attImgList+`>`+element.name+`</li>
                            `);
                        });
                    } else {
                        alert("Error to show List Cate")
                    }
                });
            } else {
                alert("Edit Failed!")
            }
        });

    });

    $("#btn_DelCate").click(function() {
        const idCate = $("#hid_ID").val()
        const urlDel = url + "/Cate/Delete"

        $.post(urlDel, {idCate: idCate}, function(dataDel) {
            const resultTruee = dataDel.result == 1
            if(resultTruee){
                $.post(urlListCate, (dataListCateFrSer) => {
                    const resultTrue = dataListCateFrSer.result == 1
                    const dataListCate = dataListCateFrSer.messenger
                    if (resultTrue) {
                        const idListCate = "#list_cate";
                        $(idListCate).html("");
                        dataListCate.forEach(element => {
                            const attImgList = element.imageName
                            const idCate = element._id
                            $(idListCate).append(`
                                <li class=Cate id=`+idCate+` srcImg=`+attImgList+`>`+element.name+`</li>
                            `);
                        });
                    } else {
                        alert("Error to show List Cate")
                    }
                });
            } else {
                alert("Delete Failed!")
            }
        });
    });

})