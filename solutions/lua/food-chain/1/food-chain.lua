local ANIMALS = { 'fly', 'spider', 'bird', 'cat', 'dog', 'goat', 'cow', 'horse' }
local EXCLAMATIVE = { 'How absurd to swallow', 'Imagine that, to swallow', 'What a hog, to swallow',
  'Just opened her throat and swallowed', 'I don\'t know how she swallowed' }

local function verse(stanza)

  local lines = {}
  table.insert(lines, 'I know an old lady who swallowed a ' .. ANIMALS[stanza] .. '.')
  if stanza == 8 then
    table.insert(lines, 'She\'s dead, of course!')
  else
    if stanza > 2 then
      table.insert(lines, EXCLAMATIVE[stanza - 2] .. ' a ' .. ANIMALS[stanza] .. '!')
    end
    for i = 1, stanza - 3 do
      table.insert(lines,
        'She swallowed the ' .. ANIMALS[stanza - i + 1] .. ' to catch the ' .. ANIMALS[stanza - i] .. '.')
    end

    if stanza > 1 then

      local subject = (stanza == 2) and 'It' or
          'She swallowed the ' .. ANIMALS[3] .. ' to catch the ' .. ANIMALS[2] .. ' that'

      table.insert(lines, subject .. ' wriggled and jiggled and tickled inside her.')
      table.insert(lines, 'She swallowed the ' .. ANIMALS[2] .. ' to catch the ' .. ANIMALS[1] .. '.')
    end

    table.insert(lines, 'I don\'t know why she swallowed the ' .. ANIMALS[1] .. '. Perhaps she\'ll die.')

  end

  table.insert(lines, '')

  return table.concat(lines, '\n')

end

local function verses(from, to)

  local res = {}
  for v = from, to do
    table.insert(res, verse(v))
  end
  table.insert(res, '')

  return table.concat(res, '\n')

end

local function sing()

  return verses(1, 8)

end

return {
  verse = verse,
  verses = verses,
  sing = sing
}
