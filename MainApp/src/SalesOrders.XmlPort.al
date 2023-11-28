xmlport 50100 "CLIP Sales Orders"
{
    Direction = Export;

    schema
    {
        textelement(Root)
        {
            tableelement(SalesHeader; "Sales Header")
            {
                SourceTableView = where("Document Type" = const(Order));

                fieldelement(Customer; SalesHeader."Sell-to Customer No.") { }
                fieldelement(No; SalesHeader."No.") { }
                // fieldattribute(NodeName3; NodeName2.SourceFieldName)
                // {

                // }
                tableelement(SalesLine; "Sales Line")
                {
                    LinkTable = SalesHeader;
                    LinkFields = "Document Type" = field("Document Type"), "Document No." = field("No.");
                    fieldelement(Type; SalesLine.Type) { }
                    fieldelement(No; SalesLine."No.") { }
                    fieldelement(Description; SalesLine.Description) { }
                }
            }
        }
    }
}