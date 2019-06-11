var objectsChecked = [];

function init(familyId){
    $("input[type=checkbox]").click(function(){
        if (this.checked) {
            var newItem = $("<span/>", {
                id: "selected-item-" + this.id
            });            
            newItem.text($("span#text-" + this.id).text());
            $("div#selected-ingredients").append(newItem);
            objectsChecked.push(this.id);
            sendChecked(familyId);
        } else {
            $("span#selected-item-" + this.id).remove();
            objectsChecked.splice($.inArray(this.id, objectsChecked), 1);
            sendChecked(familyId);
        }
    });
}

function sendChecked(family_id){
    var parent = $("#recipes-holder");
    parent.empty();
    $.getJSON("http://localhost:3000/recipes/family/" + family_id + "/search", { "checked": objectsChecked }, (json) =>{
        json.forEach((recipe)=>{
            createRecipeTab(recipe.id, recipe.name, parent);
        })    
    });
};

function createRecipeTab(id, name, parent){
    console.log("Creating tab for id:" + id + " with name: " + name);
    var holder = $("<div/>", {
        id : "recipe" + id,
    });
    holder.append($("<a>", {
        id: "link" + id,
        href: "/recipe/" + id,
        text: name
    }));
    parent.append(holder);
}

function makeCorespondingTabActive(id){
    $("a.nav-item").removeClass("active");
    $("a.nav-item[href*=" + id +"]").addClass("active");
}

