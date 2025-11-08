return function(phrase)

    local function translate(word)
    
        local pigLatin, numMatch
    
        --[[
            Rule 1: If a word begins with a vowel sound, add an "ay" sound to the end
            of the word. Please note that "xr" and "yt" at the beginning of a word make
            vowel sounds (e.g. "xray" -> "xrayay", "yttria" -> "yttriaay").
        ]]
        -- with posix regexp we could write '^([aeiou]|xr|yt).*$'
        -- but with lua patterns, we don't have '|' so we need three distinct rules
        pigLatin, numMatch = string.gsub(word, '^([aeiou].*)$', '%1ay', 1)
        if numMatch == 1 then return pigLatin end
    
        pigLatin, numMatch = string.gsub(word, '^(xr.*)$', '%1ay', 1)
        if numMatch == 1 then return pigLatin end

        pigLatin, numMatch = string.gsub(word, '^(yt.*)$', '%1ay', 1)
        if numMatch == 1 then return pigLatin end

        -- must include rule 3 before rule 2 because rule2 match is more generic
        --[[
            Rule 3: If a word starts with a consonant sound followed by "qu", move it
            to the end of the word, and then add an "ay" sound to the end of the word
            (e.g. "square" -> "aresquay").
        ]]
         pigLatin, numMatch = string.gsub(word, '^(([^aeiou]?qu)(.*))$', '%3%2ay', 1)
        if numMatch == 1 then return pigLatin end

        -- must include rule 4 before rule 2 because reule 2 match is more generic
        --[[
            Rule 4: If a word contains a "y" after a consonant cluster or as the second
            letter in a two letter word it makes a vowel sound (e.g. "rhythm" -> "ythmrhay",
            "my" -> "ymay").
        ]]
        pigLatin, numMatch = string.gsub(word, '^(([^aeiou]+)y(.*))$', 'y%3%2ay', 1)
        if numMatch == 1 then return pigLatin end
    
        --[[
            Rule 2: If a word begins with a consonant sound, move it to the end of the
            word and then add an "ay" sound to the end of the word. Consonant sounds can
            be made up of multiple consonants, a.k.a. a consonant cluster 
            (e.g. "chair" -> "airchay").
        ]]
        pigLatin, numMatch = string.gsub(word, '^(([^aeiou]+)(.*))$', '%3%2ay', 1)
        if numMatch == 1 then return pigLatin end

        -- no rule match, just return the input word
        return word

    end

    local res = {}
    for word in string.gmatch(phrase, '%w+') do
        res[#res+1] = translate(word)
    end
    return table.concat(res, ' ')
    
end
