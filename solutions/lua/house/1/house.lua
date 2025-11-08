local house = {}

house.additions = {
        ' the',
        ' the malt\nthat lay in the',
        ' the rat\nthat ate the',
        ' the cat\nthat killed the',
        ' the dog\nthat worried the',
        ' the cow with the crumpled horn\nthat tossed the',
        ' the maiden all forlorn\nthat milked the',
        ' the man all tattered and torn\nthat kissed the',
        ' the priest all shaven and shorn\nthat married the',
        ' the rooster that crowed in the morn\nthat woke the',
        ' the farmer sowing his corn\nthat kept the',
        ' the horse and the hound and the horn\nthat belonged to the',
}

house.verse = function(which)
    local verse = 'This is the house that Jack built.'
    for i = 1, which do
        verse = verse:gsub(' the', house.additions[i], 1)
    end
    return verse
end

house.recite = function()
    local verses = ''
    for i = 1, #house.additions do
        if i > 1 then
            verses = verses .. '\n'
        end
        verses = verses .. house.verse(i)
    end
    return verses
end

return house
