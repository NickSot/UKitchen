

function passToModal(familyId, shoppingListId, itemId, itemName){
    path = '/families/' + familyId + '/shopping_lists/' + shoppingListId + '/add_item/' + itemId;
    $(".add-item").attr("action", path);
    console.log(itemName);
    $("#modal-lable").text(itemName)
}