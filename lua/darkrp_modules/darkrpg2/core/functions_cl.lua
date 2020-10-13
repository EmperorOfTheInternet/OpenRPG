function EOTI_CreateFont(size,font,weight,title)
    surface.CreateFont( "EOTI_"..title.."_"..size, {
    font = font,
    size = size,
    weight = 400,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
    } )
end
EOTI_CreateFont(100,"CloseCaption_Bold",800,"HIT")

function string.wrapwords(Str,font,width)
    if( font ) then  --Dr Magnusson's much less prone to failure and more optimized version
         surface.SetFont( font )  
    end  
    local tbl, len, Start, End = {}, string.len( Str ), 1, 1  
    while ( End < len ) do  
        End = End + 1  
        if ( surface.GetTextSize( string.sub( Str, Start, End ) ) > width ) then  
            local n = string.sub( Str, End, End )  
            local I = 0  
            for i = 1, 15 do  
                I = i  
                if( n != " " and n != "," and n != "." and n != "\n" ) then  
                    End = End - 1  
                    n = string.sub( Str, End, End )  
                else  
                    break  
                end  
            end  
            if( I == 15 ) then  
                End = End + 14  
            end  
            local FnlStr = string.Trim( string.sub( Str, Start, End ) )  
            table.insert( tbl, FnlStr )  
            Start = End + 1  
        end                   
    end  
    table.insert( tbl, string.sub( Str, Start, End ) )  
    return table.concat(tbl,"\n")  
end

function string.checktextlen(panel, str1, str2, str3)
    panel:SetText(str1)
    panel:SizeToContentsX()
    local a = panel:GetWide()
    panel:SetText(str2)
    panel:SizeToContentsX()
    local b = panel:GetWide()
    panel:SetText(str3)
    panel:SizeToContentsX()
    return math.max(a,b,panel:GetWide())
end

function loadAndApplyStyleSheet()
    print("DarkRPG CLIENT: Including '"..DarkRPG.Config.HUDStyle..".lua'!")
    AddCSLuaFile( "darkrp_modules/darkrpg2/hud/"..DarkRPG.Config.HUDStyle..".lua" )
    include( "darkrp_modules/darkrpg2/hud/"..DarkRPG.Config.HUDStyle..".lua" )
end
loadAndApplyStyleSheet()