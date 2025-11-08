return function(letter)

    local function replaceChar(str, pos, r)
        return str:sub(1, pos-1) .. r .. str:sub(pos+1)
    end

    local rows = {}
    local rank = string.byte(letter) - string.byte('A')

    -- The size of the diamond (heigth/width) is increasing by 2 with each letter
    -- (and starts at 1 with 'A')
    local nLines = 2 * rank + 1
    local blankLine = string.rep(' ', nLines)

    for line = 0, nLines-1 do
        
        -- The letters increase alphabetically until we get to the middle (
        -- line = rank) of the diamond. They then decrease alphabetically with each line.

        local letterIndex = (line <= rank) and line or (nLines - line - 1)
        local currentLetter = string.char(string.byte('A') + letterIndex)

        -- Use an array of letter rather than a string, it is easier to manipulate
        -- Fill it with blank and copy the letter in two positions.
        -- The first line starts with the letter at the center (rank) and then moving
        -- to each side by one character (same as letter index).
        -- 'A' can be seen as a special case where both 'A' are written on top of each 
        -- other (at the center of the line)

        local lineContent = replaceChar(blankLine, 1+rank-letterIndex, currentLetter)
        lineContent = replaceChar(lineContent, 1+rank+letterIndex, currentLetter)
        table.insert(rows, lineContent)
            
    end
    table.insert(rows, '')
    return table.concat(rows, '\n')
end
