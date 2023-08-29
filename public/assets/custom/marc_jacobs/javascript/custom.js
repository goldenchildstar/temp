$(document).ready(function(){

    var MMD_window_H = $(window).height();
    var MMD_window_W = $(window).width();
    MMD_headerSize();

    $(window).on('resize', function(){

        MMD_window_H = $(window).height();
        MMD_window_W = $(window).width();
        MMD_headerSize();

    });


    $('#phone').blur(function(event){
        $('#phone').attr('placeholder', "Téléphone");
    });

    // Animation Bloc Mentions Légales & CGU
    $( "#MMD_footerDGClick" ).click(function() {
        $('#MMD_conditions').css({'display':'block'});
        $('#MMD_conditions').animate({'opacity':'1'}, 300, 'easeInCubic');
    });

    $( "#link_cgu" ).click(function() {
        $('#MMD_conditions').css({'display':'block'});
        $('#MMD_conditions').animate({'opacity':'1'}, 300, 'easeInCubic');
    });

    // Checkbox CGU liée au label
    var cguClick = 0;
    $('.text-cgu').click(function(){
        if(cguClick === 0){
            $('#cgu').prop('checked',true);
            cguClick = 1;
        }else{
            $('#cgu').prop('checked',false);
            cguClick = 0;
        }

    });

    $('.text-cgu').click(function() {
        $('.cgu').removeClass('parsley-error');
        $('#parsley-id-multiple-cgu').addClass('hidden');
    });
    $('#cgu').click(function() {
        $('.cgu').removeClass('parsley-error');
        $('#parsley-id-multiple-cgu').addClass('hidden');
    });


    $( "#MMD_conditionsCClick" ).click(function() {
        $('#MMD_conditions').animate({'opacity':'0'}, 300, 'easeInCubic', function(){$('#MMD_conditions').css({'display':'none'});});
    });
    $( "#MMD_footerMLClick" ).click(function() {
        $('#MMD_mentions').css({'display':'block'});
        $('#MMD_mentions').animate({'opacity':'1'}, 300, 'easeInCubic');
    });
    $( "#MMD_mentionsCClick" ).click(function() {
        $('#MMD_mentions').animate({'opacity':'0'}, 300, 'easeInCubic', function(){$('#MMD_mentions').css({'display':'none'});});
    });


    function MMD_headerSize(){

        if(MMD_window_H > 820){
            $('.MMD_conditionsTexte').css({'height':(MMD_window_H-250)+'px'});
            $('#MMD_conditionsHeader, .MMD_conditionsTitre').css({'height':'100px','line-height': '100px'});
            $('.MMD_conditionsClose').css({'top':'10px'});
            $('.MMD_conditionsLogo').css({'width':'95px'});
        }else if(MMD_window_H <= 820 && MMD_window_H > 800){
            $('.MMD_conditionsTexte').css({'height':(MMD_window_H-250)+'px'});
            $('#MMD_conditionsHeader, .MMD_conditionsTitre').css({'height':'100px','line-height': '100px'});
            $('.MMD_conditionsClose').css({'top':'10px'});
            $('.MMD_conditionsLogo').css({'width':'95px'});
        }else if(MMD_window_H <= 800 && MMD_window_H > 775){
            $('.MMD_conditionsTexte').css({'height':(MMD_window_H-250)+'px'});
            $('#MMD_conditionsHeader, .MMD_conditionsTitre').css({'height':'100px','line-height': '100px'});
            $('.MMD_conditionsClose').css({'top':'10px'});
            $('.MMD_conditionsLogo').css({'width':'95px'});
        }else if(MMD_window_H <= 775 && MMD_window_H > 750){
            $('.MMD_conditionsTexte').css({'height':(MMD_window_H-250)+'px'});
            $('#MMD_conditionsHeader, .MMD_conditionsTitre').css({'height':'100px','line-height': '100px'});
            $('.MMD_conditionsClose').css({'top':'10px'});
            $('.MMD_conditionsLogo').css({'width':'95px'});
        }else if(MMD_window_H <= 750 && MMD_window_H > 700){
            $('.MMD_conditionsTexte').css({'height':(MMD_window_H-250)+'px'});
            $('#MMD_conditionsHeader, .MMD_conditionsTitre').css({'height':'100px','line-height': '100px'});
            $('.MMD_conditionsClose').css({'top':'10px'});
            $('.MMD_conditionsLogo').css({'width':'95px'});
        }else if(MMD_window_H <= 700 && MMD_window_H > 650){
            $('.MMD_conditionsTexte').css({'height':(MMD_window_H-250)+'px'});
            $('#MMD_conditionsHeader, .MMD_conditionsTitre').css({'height':'100px','line-height': '100px'});
            $('.MMD_conditionsClose').css({'top':'10px'});
            $('.MMD_conditionsLogo').css({'width':'95px'});
        }else if(MMD_window_H <= 650 && MMD_window_H > 600){
            $('.MMD_conditionsTexte').css({'height':(MMD_window_H-250)+'px'});
            $('#MMD_conditionsHeader, .MMD_conditionsTitre').css({'height':'100px','line-height': '100px'});
            $('.MMD_conditionsClose').css({'top':'10px'});
            $('.MMD_conditionsLogo').css({'width':'95px'});
        }else if(MMD_window_H <= 600 && MMD_window_H > 550){
            $('.MMD_conditionsTexte').css({'height':(MMD_window_H-250)+'px'});
            $('#MMD_conditionsHeader, .MMD_conditionsTitre').css({'height':'100px','line-height': '100px'});
            $('.MMD_conditionsClose').css({'top':'10px'});
            $('.MMD_conditionsLogo').css({'width':'95px'});
        }else if(MMD_window_H <= 550 && MMD_window_H > 500){
            $('.MMD_conditionsTexte').css({'height':(MMD_window_H-150)+'px'});
            $('#MMD_conditionsHeader, .MMD_conditionsTitre').css({'height':'50px','line-height': '50px'});
            $('.MMD_conditionsClose').css({'top':'16px'});
            $('.MMD_conditionsLogo').css({'width':'50px'});
        }else if(MMD_window_H <= 500 && MMD_window_H > 450){
            $('.MMD_conditionsTexte').css({'height':(MMD_window_H-150)+'px'});
            $('#MMD_conditionsHeader, .MMD_conditionsTitre').css({'height':'50px','line-height': '50px'});
            $('.MMD_conditionsClose').css({'top':'16px'});
            $('.MMD_conditionsLogo').css({'width':'50px'});
        }else if(MMD_window_H <= 450 && MMD_window_H > 400){
            $('.MMD_conditionsTexte').css({'height':(MMD_window_H-150)+'px'});
            $('#MMD_conditionsHeader, .MMD_conditionsTitre').css({'height':'50px','line-height': '50px'});
            $('.MMD_conditionsClose').css({'top':'16px'});
            $('.MMD_conditionsLogo').css({'width':'50px'});
        }else{
            $('#MMD_conditionsHeader, .MMD_conditionsTitre').css({'height':'50px', 'line-height': '50px'});
            $('.MMD_conditionsClose').css({'top':'16px'});
            $('.MMD_conditionsLogo').css({'width':'50px'});
            $('.MMD_conditionsTexte').css({'height':'300px'});
        }

    }
});