

function passItemToAddToModal(familyId, shoppingListId, itemId, itemName){
    path = '/families/' + familyId + '/shopping_lists/' + shoppingListId + '/add_item/' + itemId;
    $(".add-item").attr("action", path);
    $("#modal-lable").text(itemName)
}

function passItemToBuyToModal(path, unit){
    $(".add-item").attr("action", path);
    $("input[name=quantity]").attr("placeholder", "quantity(" + unit + ")" )
}