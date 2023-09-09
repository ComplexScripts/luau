local FileSystem = {}

local HTTPService = game:GetService("HttpService")
local Encode, Decode = function(Data)
    return HTTPService:JSONEncode(Data)
end, function(Data)
    return HTTPService:JSONDecode(Data)
end

function FileSystem:Save(FilePath, DataTable)
    local Data = {}

    for Key, Value in next, DataTable do
        Data[Key] = Value
    end

    Data = Encode(Data)

    writefile(FilePath, Data)
end

function FileSystem:Retrieve(FilePath)
    if isfile(FilePath) then
        return Decode(readfile(FilePath))
    end
end

function FileSystem:Rewrite(FilePath, DataTable)
    local Data = self:Retrieve(FilePath)

    for Key, Value in next, DataTable do
        if Data[Key] then
            Data[Key] = Value
        end
    end

    self:Save(FilePath, Data)
end

return FileSystem
