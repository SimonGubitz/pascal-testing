unit Types;

interface

type TListEntity = record
    EntityTicked: Boolean;
    EntityText: string;
    EntityDate: TDateTime;
end;

type TList = record
    ListName: string;
    ListDescription: string;
    ListEntities: array of TListEntity;
end;

implementation

end.