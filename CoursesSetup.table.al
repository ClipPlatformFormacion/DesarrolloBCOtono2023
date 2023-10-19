table 50101 "Courses Setup"
{
    CaptionML = ENU = 'Courses Setup', ESP = 'Conf. cursos';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            CaptionML = ENU = 'Primary Key', ESP = 'Clave primaria';
        }
        field(2; "Course Nos."; Code[20])
        {
            CaptionML = ENU = 'Resource Nos.', ESP = 'Nº serie curso';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
}

