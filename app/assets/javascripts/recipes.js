$(document).ready(()=>{
    let id = family_id;
    if(id != -1){
        makeCorespondingTabActive(id);
    }
});

function makeCorespondingTabActive(id){
    $("a.nav-item").removeClass("active");
    $("a.nav-item[href*=" + id +"]").addClass("active");
}
