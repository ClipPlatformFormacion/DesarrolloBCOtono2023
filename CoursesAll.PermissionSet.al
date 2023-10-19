permissionset 50100 "Courses - All"
{
    CaptionML = ENU = 'Courses - All permissions', ESP = 'Cursos - Todos los permisos';
    Assignable = true;
    Permissions =
        tabledata "Courses Setup" = RIMD,
        tabledata "Courses" = RIMD,
        tabledata "Course Edition" = RIMD,
        table "Course Edition" = X,
        table Courses = X,
        table "Courses Setup" = X,
        page "Course Card" = X,
        page "Course Editions" = X,
        page "Course Editions Factbox" = X,
        page "Courses List" = X,
        page "Courses Setup" = X;
}