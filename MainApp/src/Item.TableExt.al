tableextension 50101 "CLIP Item" extends Item
{
    fieldgroups
    {
        addlast(Brick; "Vendor No.") { }
        addlast(DropDown; "Substitutes Exist", Inventory) { }
    }
}