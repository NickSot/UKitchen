

function passItemToAddToModal(familyId, shoppingListId, itemId, itemName, unit){
    path = '/families/' + familyId + '/shopping_lists/' + shoppingListId + '/add_item/' + itemId;
    $(".add-item").attr("action", path);
    $("#modal-lable").text(itemName)
    $("span#quantity-placeholder").text(unit);
}

function passItemToBuyToModal(path, unit){
    $(".add-item").attr("action", path);
    $("input[name=quantity]").attr("placeholder", "quantity(" + unit + ")" )
}