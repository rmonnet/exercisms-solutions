local triangle = {}


function triangle.kind(a, b, c)

    assert(a > 0 and b > 0 and c > 0, 'Input Error')
    assert(a + b > c, 'Input Error')
    assert(a + c > b, 'Input Error')
    assert(b + c > a, 'Input Error')

    if a == b and b == c then
        return 'equilateral'
    elseif a == b or a == c or b == c then
        return 'isosceles'
    else
        return 'scalene'
    end

end

return triangle
    