program TodoApp;

uses
    SysUtils, Homepage;


procedure Main;
begin

    InputDrawHomepage;

end; 

begin
    try
        Main;
    except
        on E:   do
        begin
            WriteLn('Error: ', E.Message);
        end;
    end;
end.