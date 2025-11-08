return function(s)

    local acronym = {}

    for word in s:gmatch('%w+') do

        if word == word:upper() or word == word:lower() then
            table.insert(acronym, word:sub(1, 1):upper())
        else
            for letter in word:gmatch('[A-Z]') do
                table.insert(acronym, letter)
            end
        end

    end

    return table.concat(acronym)

end
