codeunit 60003 "CLIP Customer Level Management"
{
    [EventSubscriber(ObjectType::Table, Database::Customer, "CLIP OnValidateCustomerLevelOnBeforeUnknownLevelValue", '', false, false)]
    local procedure "CLIP OnValidateCustomerLevelOnBeforeUnknownLevelValue"(var Customer: Record Customer; var Handled: Boolean);
    begin
        if Customer."CLIP Level" <> "CLIP Customer Level"::"CLIP Gold" then
            exit;

        Customer.Validate("CLIP Discount", 15);
        Handled := true;
    end;
}