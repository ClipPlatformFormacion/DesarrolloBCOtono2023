permissionset 50100 "CLIP Courses - All"
{
    Caption = 'Courses - All permissions', Comment = 'ESP="Cursos - Todos los permisos"';
    Assignable = true;
    Permissions =
        tabledata "CLIP Courses Setup" = RIMD,
        tabledata "CLIP Course" = RIMD,
        tabledata "CLIP Course Edition" = RIMD,
        table "CLIP Course Edition" = X,
        table "CLIP Course" = X,
        table "CLIP Courses Setup" = X,
        page "CLIP Course Card" = X,
        page "CLIP Course Editions" = X,
        page "CLIP Course Editions Factbox" = X,
        page "CLIP Courses List" = X,
        page "CLIP Courses Setup" = X;
}