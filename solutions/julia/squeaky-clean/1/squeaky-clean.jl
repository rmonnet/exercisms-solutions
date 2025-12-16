function transform(ch)
    if ch == '-'
        return "_"
    elseif ch == ' '
        return ""
    elseif isuppercase(ch)
        return "-" * lowercase(ch)
    elseif isdigit(ch)
        return ""
    elseif 'α' <= ch <= 'ω'
        return "?"
    else
        return string(ch)
    end
end

function clean(str)
    cleaned_str = ""
    for ch in collect(str)
        cleaned_str *= transform(ch)
    end
    return cleaned_str
end
