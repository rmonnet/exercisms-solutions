-- bottle decides if we need to print 'no more bottles', '1 bottle', or 'N bottles'
local function bottle(n)
    if n == 0 then
        return 'no more bottles'
    elseif n == 1 then
        return '1 bottle'
    else
        return tostring(n) .. ' bottles'
    end
end

-- take decides if we need to print 'Take it' or 'Take one'
local function take(n)
    if n == 1 then
        return 'Take it'
    else
        return 'Take one'
    end
end

local beer = {}

function beer.verse(number)

    if number == 0 then
        return 'No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n'
    else
        return string.format(
            '%s of beer on the wall, %s of beer.\n%s down and pass it around, %s of beer on the wall.\n',
            bottle(number), bottle(number), take(number), bottle(number - 1))
    end

end

function beer.sing(start, finish)

    local finish = finish or 0
    local song = {}
    for i = start, finish, -1 do
        table.insert(song, beer.verse(i))
    end

    return table.concat(song, '\n')

end

return beer
